import UIKit
import SnapKit
import Then
import Core
import RxCocoa
import RxSwift
import MintKit

@available(iOS 16.0, *)
public class FindIdViewController: BaseFindVC {
    var disposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "아이디 찾기"
        updateWith(self)
        
        mainButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                let id = self.mintFindTextField.textField1.text ?? ""
                let password = self.certificationOneTextField.textField1.text ?? ""
                
                if password.isEmpty || id.isEmpty {
                    self.shakePaintingLogo()
                } else {
                    self.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(FindIdResultViewController(), animated: true)
                }
            }).disposed(by: disposeBag)
        
        mintFindTextField.button1.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
               print("findIdButton")
                let number = self.mintFindTextField.textField1.text
                
                if number!.isEmpty {
                    self.shakePaintingLogo()
                } else {
                    print("인증번호 발송")
                }
            }).disposed(by: disposeBag)
        
        let certificationTextField = mintFindTextField.textField1.rx.text.orEmpty.asObservable()
        let certificationOneTextField = certificationOneTextField.textField1.rx.text.orEmpty.asObservable()
        
        Observable.combineLatest(certificationTextField, certificationOneTextField)
            .map { id, password -> Bool in
                return !id.isEmpty && !password.isEmpty
            }
            .bind { [weak self] allFieldsFilled in
                self?.mainButton.layer.opacity = allFieldsFilled ? 1.0 : 0.5
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(certificationTextField, certificationOneTextField)
            .map { id, password -> Bool in
                return !id.isEmpty
            }
            .bind { [weak self] allFieldsFilled in
                self?.mintFindTextField.button1.layer.opacity = allFieldsFilled ? 1.0 : 0.5
            }
            .disposed(by: disposeBag)

    }
    
    private func shakePaintingLogo() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 5
        shakeAnimation.autoreverses = true
        
        let fromPoint = CGPoint(x: paintingLogo.center.x - 5, y: paintingLogo.center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: paintingLogo.center.x + 5, y: paintingLogo.center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shakeAnimation.fromValue = fromValue
        shakeAnimation.toValue = toValue
        
        self.paintingLogo.layer.add(shakeAnimation, forKey: "position")
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
   }
}
