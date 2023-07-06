import UIKit
import SnapKit
import Then
import Core
import MintKit

public class BaseFindVC: UIViewController {
    
    public var mintFindTextField = MintCertificationTwoTextField(placeholder1: "전화번호를 입력해주세요.", buttonText: "인증받기", buttonTextColor: .white)
    
    public var certificationOneTextField = MintOneTextField(placeholder1: "인증번호를 입력해주세요.")
    
    public var mainButton = MintButton(buttonTitle: "아이디 찾기", titleColor: .white)
    
    public var paintingLogo = UIImageView().then {
        $0.image = MintKitAsset.Assets.paintingLogo.image
        //불투명도 코드
        $0.layer.opacity = 0.5
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "아이디 찾기"
        
        updateWith(self)
    }
    
    func updateWith(_ controller: UIViewController) {
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        view.addSubview(paintingLogo)
        view.addSubview(mintFindTextField)
        view.addSubview(certificationOneTextField)
        view.addSubview(mainButton)
        
        mintFindTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80.0)
            
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(72.0)
        }
        
        certificationOneTextField.snp.makeConstraints {
            $0.top.equalTo(mintFindTextField.snp.bottom)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(72.0)
        }
        
        mainButton.snp.makeConstraints {
            $0.top.equalTo(certificationOneTextField.snp.bottom).offset(10.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
        }
        
        paintingLogo.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(60.0)
            $0.trailing.equalToSuperview().offset(120.0)
            $0.height.width.equalTo(306.0)
        }
    }
}

