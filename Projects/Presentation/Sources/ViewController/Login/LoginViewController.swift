import UIKit
import SnapKit
import Then
import Core
import MintKit

public class LoginViewController: UIViewController {
    
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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        print("시작됨")
        layout()
    }
    
    private func layout() {
        
        [
            mintTitleLogo,
            mintTextField,
            loginButton,
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
        
        paintingLogo.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(60.0)
            $0.trailing.equalToSuperview().offset(120.0)
            $0.height.width.equalTo(306.0)
        }
    }
}
