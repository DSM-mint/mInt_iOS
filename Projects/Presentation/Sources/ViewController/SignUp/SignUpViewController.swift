import UIKit
import SnapKit
import Then
import Core
import MintKit
import RxSwift
import RxCocoa

@available(iOS 16.0, *)
public class SignUpViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private var userImageView = AddPictureView(titleText: "사진 추가하기")
    
    private var mintFourTextField = MintFourTextField(placeholder1: "이름을 입력해주세요.", placeholder2: "아이디를 입력해주세요.", placeholder3: "이메일을 입력해주세요.", placeholder4: "비밀번호를 입력해주세요.")
    
    private var signUpButton = MintButton(buttonTitle: "가입하기", titleColor: .white)
   
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        mintFourTextField.textField2.isSecureTextEntry = false
        
        title = "회원가입"
        userImageView.pictureButton.addTarget(self, action: #selector(chooseImage(_:)), for: .touchUpInside)
        
        view.addSubview(userImageView)
        view.addSubview(mintFourTextField)
        view.addSubview(signUpButton)
        signUpButton.layer.opacity = 0.5
        
        userImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(105.0)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(140.0)
        }
        
        mintFourTextField.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(270.0)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(mintFourTextField.snp.bottom).offset(40.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(370.0)
            $0.height.equalTo(54.0)
        }
        
        let nameTextField = mintFourTextField.textField1.rx.text.orEmpty.asObservable()
        let idTextField = mintFourTextField.textField2.rx.text.orEmpty.asObservable()
        let emailTextField = mintFourTextField.textField3.rx.text.orEmpty.asObservable()
        let passwordTextField = mintFourTextField.textField4.rx.text.orEmpty.asObservable()

        Observable.combineLatest(nameTextField, idTextField, emailTextField, passwordTextField)
            .map { name, id, email, password -> Bool in
                return !name.isEmpty && !id.isEmpty && !email.isEmpty && !password.isEmpty
            }
            .bind { [weak self] allFieldsFilled in
                self?.signUpButton.layer.opacity = allFieldsFilled ? 1.0 : 0.5
            }
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
               print("findIdButton")
                let name = self.mintFourTextField.textField1.text ?? ""
                let id = self.mintFourTextField.textField2.text ?? ""
                let email = self.mintFourTextField.textField3.text ?? ""
                let password = self.mintFourTextField.textField4.text ?? ""
                
                if name.isEmpty || id.isEmpty || email.isEmpty || password.isEmpty {
                    self.shakeUserImageView()
                } else {
                    print("회원가입")
                    guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                    for viewController in viewControllerStack {
                      if let bView = viewController as? LoginViewController {
                        self.navigationController?.popToViewController(bView, animated: true)
                        }
                    }
                }
            }).disposed(by: disposeBag)
        
        setupKeyboardObservers()
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
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
    
    private func shakeUserImageView() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 2
        shakeAnimation.autoreverses = true
        
        let fromPoint = CGPoint(x: userImageView.center.x - 10, y: userImageView.center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: userImageView.center.x + 10, y: userImageView.center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shakeAnimation.fromValue = fromValue
        shakeAnimation.toValue = toValue
        
        userImageView.layer.add(shakeAnimation, forKey: "position")
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
    
    @objc func chooseImage(_ sender:UIButton) {
        openImagePicker()
    }
}

@available(iOS 16.0, *)
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "사진추가", message: "사진을 추가하는 방식을 선택해주세요", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "카메라사용", style: .default, handler: { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "앨범에서 가져오기", style: .default, handler: { (_) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.pictureImage.image = selectedImage
            userImageView.pictureImage.layer.cornerRadius = 10.0
            userImageView.pictureImage.clipsToBounds = true
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
