import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core
import MintKit

protocol EmotionDelegate: AnyObject {
    func didAddEmotion(emotion: String)
}

public class EmotionViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    var addButtonBottomConstraint: Constraint?
    
    weak var delegate: EmotionDelegate?
    
    private(set) var addedEmotion: String? = nil

    private var mainTextField = MintOneTextField(placeholder1: "감정을 입력해주세요.")
    private var addButton = MintButton(buttonTitle: "추가하기", titleColor: .white)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "감정 추가"
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        
        layout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        addButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.addedEmotion = self.mainTextField.textField1.text
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let addedEmotion = addedEmotion {
            delegate?.didAddEmotion(emotion: addedEmotion)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func layout() {
        view.addSubview(mainTextField)
        view.addSubview(addButton)
        
        mainTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(45.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(50.0)
        }
        
        addButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
            self.addButtonBottomConstraint = $0.bottom.equalToSuperview().offset(-110.0).constraint
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            UIView.animate(withDuration: 0.3) {
                self.addButtonBottomConstraint?.update(offset: -(keyboardHeight + 10))
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.addButtonBottomConstraint?.update(offset: -110.0)
            self.view.layoutIfNeeded()
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
   }
}
