import UIKit
import SnapKit
import Then
import Core
import RxCocoa
import RxSwift
import MintKit

public class FindPassswordViewController: BaseFindVC {
    var disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "비밀번호 찾기"
        updateWith(self)
        mainButton.setTitle("비밀번호 찾기", for: .normal)
        
        mainButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                self.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
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
