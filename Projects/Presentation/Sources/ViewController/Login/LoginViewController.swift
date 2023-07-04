import UIKit
import SnapKit
import Then
import Core
import MintKit
import RxSwift
import RxCocoa

public class LoginViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private var mintTitleLogo = UIImageView().then {
        $0.image = MintKitAsset.Assets.mintLogo.image
    }
    
    private var mintTextField = MintTwoTextField(placeholder1: "아이디를 입력해주세요.", placeholder2: "비밀번호를 입력해주세요.")
    
    private var loginButton = MintButton(buttonTitle: "로그인", titleColor: .white)
    
    private var paintingLogo = UIImageView().then {
        $0.image = MintKitAsset.Assets.paintingLogo.image
        //불투명도 코드
        $0.layer.opacity = 0.5
    }
    
    private var findIdButton = UIButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(MintKitAsset.Colors.gary500.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15.0)
    }
    
    private var findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(MintKitAsset.Colors.gary500.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15.0)
    }
    
    private var signupButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(MintKitAsset.Colors.gary500.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15.0)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        print("시작됨")
        layout()
        
        findIdButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
               print("findIdButton")
                self.navigationController?.pushViewController(FindIdViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        findPasswordButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
               print("findPasswordButton")
                self.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(FindPassswordViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        signupButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
               print("findPasswordButton")
            }).disposed(by: disposeBag)
        
        loginButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                let tapbarVC = TapbarViewController()
                tapbarVC.modalPresentationStyle = .fullScreen
                self.present(tapbarVC, animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    private func layout() {
        
        [
            mintTitleLogo,
            mintTextField,
            loginButton,
            findIdButton,
            findPasswordButton,
            signupButton,
            paintingLogo
        ].forEach { view.addSubview($0) }
        
        mintTitleLogo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(233.0)
            $0.leading.equalToSuperview().inset(30.0)
            $0.width.equalTo(73.0)
            $0.height.equalTo(28.0)
        }
        
        mintTextField.snp.makeConstraints {
            $0.top.equalTo(mintTitleLogo.snp.bottom).offset(29.0)
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(130.0)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(mintTextField.snp.bottom).offset(28.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(370.0)
            $0.height.equalTo(54.0)
        }
        
        findIdButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10.0)
            $0.leading.equalTo(loginButton.snp.leading).offset(46.0)
            $0.height.equalTo(22.0)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(6.0)
            $0.leading.equalTo(findIdButton.snp.trailing).offset(36.0)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(6.0)
            $0.leading.equalTo(findPasswordButton.snp.trailing).offset(36.0)
        }
        
        paintingLogo.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(60.0)
            $0.trailing.equalToSuperview().offset(120.0)
            
            $0.height.width.equalTo(306.0)
        }
    }
}
