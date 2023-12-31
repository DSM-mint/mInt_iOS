import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core
import MintKit

//1
@available(iOS 16.0, *)
public class WriteDiaryViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private var writeTitle = UILabel().then {
        $0.text = "오늘 일어난 일을 적어보세요."
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    private var mintTextView = MintTextView(textViewHeight: 300.0)
    
    private let mainTextField = MintOneTextField(placeholder1: "제목을 입력해주세요.")
    private let progressBarView = ProgressBarView()
    
    private let nextButton = MintButton(buttonTitle: "다음 단계", titleColor: .white)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "일기 작성하기"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        
        var timer = 0.0
        let finish = 3.0
        timer += 1
        self.progressBarView.ratio = timer / finish
        layout()
        
        nextButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                self.navigationController?.pushViewController(WriteMoodViewController(), animated: true)
            }).disposed(by: disposeBag)
        setupKeyboardObservers()
        
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { [weak self] notification in
                self?.keyboardWillShow(notification: notification)
            })
            .disposed(by: disposeBag)

        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { [weak self] notification in
                self?.keyboardWillHide(notification: notification)
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        view.frame.origin.y = 0 - keyboardHeight * 0.3
    }

    @objc private func keyboardWillHide(notification: Notification) {
        view.frame.origin.y = 0
    }
    
    private func shakePaintingLogo() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 5
        shakeAnimation.autoreverses = true
        
        let fromPoint = CGPoint(x: mainTextField.center.x - 5, y: mainTextField.center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: mainTextField.center.x + 5, y: mainTextField.center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shakeAnimation.fromValue = fromValue
        shakeAnimation.toValue = toValue
        
        self.writeTitle.layer.add(shakeAnimation, forKey: "position")
    }
    
    func layout() {
        view.addSubview(writeTitle)
        view.addSubview(progressBarView)
        view.addSubview(mainTextField)
        view.addSubview(mintTextView)
        view.addSubview(nextButton)
        
        writeTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        progressBarView.snp.makeConstraints {
            $0.top.equalTo(writeTitle.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(4.0)
            $0.width.equalTo(370.0)
        }
        
        mainTextField.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(40.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(50.0)
        }
        
        mintTextView.snp.makeConstraints {
            $0.top.equalTo(mainTextField.snp.bottom).offset(12.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(300.0)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(mintTextView.snp.bottom).offset(150.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
   }
}
