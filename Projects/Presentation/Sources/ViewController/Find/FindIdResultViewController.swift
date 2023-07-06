import UIKit
import SnapKit
import Then
import Core
import RxCocoa
import RxSwift
import MintKit

@available(iOS 16.0, *)
public class FindIdResultViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    private var mintTitleLogo = UIImageView().then {
        $0.image = MintKitAsset.Assets.blogo.image
    }
    
    private var findLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        let string = "회원님의 아이디는 junha입니다."
        let attributedString = NSMutableAttributedString(string: string)
        
        if let nameRange = string.range(of: "junha") {
            let nsRange = NSRange(nameRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: nsRange)
        }
        
        if let otherTextRange = string.range(of: "회원님의 아이디는") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }
        
        if let otherTextRange = string.range(of: "입니다.") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }
        
        $0.attributedText = attributedString
    }
    
    private var gotoLoginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(MintKitAsset.Colors.gary500.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15.0)
    }
    
    private var gotoFindPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(MintKitAsset.Colors.gary500.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15.0)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        layout()
        
        let logoTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logoTapped))
        mintTitleLogo.isUserInteractionEnabled = true
        mintTitleLogo.addGestureRecognizer(logoTapGestureRecognizer)
        
        gotoLoginButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                self.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        gotoFindPasswordButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                self.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(FindPassswordViewController(), animated: true)
            }).disposed(by: disposeBag)
    }
    
    @objc func logoTapped() {
        UIView.animate(withDuration: 0.5, animations: {
            self.mintTitleLogo.center.x += self.view.bounds.width
        }, completion: { _ in
            self.mintTitleLogo.isHidden = true
            //             필요하다면 이미지 뷰를 다른 위치로 되돌릴 수 있습니다.
            //             self.mintTitleLogo.center.x -= self.view.bounds.width
        })
    }
    
    func layout() {
        view.addSubview(findLabel)
        view.addSubview(gotoLoginButton)
        view.addSubview(gotoFindPasswordButton)
        view.addSubview(mintTitleLogo)
        
        findLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(217.0)
            $0.centerX.equalToSuperview()
        }
        
        gotoLoginButton.snp.makeConstraints {
            $0.top.equalTo(findLabel.snp.bottom).offset(27.0)
            $0.leading.equalToSuperview().offset(135.0)
            $0.height.equalTo(50.0)
            $0.width.equalTo(50.0)
        }
        
        gotoFindPasswordButton.snp.makeConstraints {
            $0.top.equalTo(gotoLoginButton.snp.top)
            $0.leading.equalTo(gotoLoginButton.snp.trailing).offset(31.0)
            $0.height.equalTo(50.0)
            $0.width.equalTo(100.0)
        }
        
        mintTitleLogo.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(270.0)
        }
    }
}
