import UIKit
import SnapKit
import Then
import Core
import MintKit
import RxSwift
import RxCocoa

protocol UserViewControllerDelegate: AnyObject {
    func userProfileDataChanged(newName: String)
}
var name: String = "박준하"

public class UserViewController: UIViewController, UserViewControllerDelegate {
    
    var disposeBag = DisposeBag()
    
    lazy var navLabel = UILabel().then {
        $0.textColor = UIColor.white
        $0.text = "마이페이지"
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
    }

    private var welcomeLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 23.0, weight: .bold)
        let string = "\(name) 님,\n안녕하세요~!"
        let attributedString = NSMutableAttributedString(string: string)

        if let nameRange = string.range(of: "\(name)") {
            let nsRange = NSRange(nameRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: nsRange)
        }

        if let otherTextRange = string.range(of: " 님,\n안녕하세요~!") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }

        $0.attributedText = attributedString
    }
    
    private var userImageView = UIImageView().then {
        $0.image = MintKitAsset.Assets.logo.image
        $0.layer.cornerRadius = 10.0
        $0.clipsToBounds = true
    }
    
    private var sadButton = UIButton().then {
        $0.setImage(MintKitAsset.Assets.sadButton.image, for: .normal)
    }
    
    private var profileEditButton = UIButton().then {
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitle("프로필 수정하기", for: .normal)
    }
    
    
    func userProfileDataChanged(newName: String) {
        name = newName

        updateWelcomeLabel(with: name)
    }
    
    private func updateWelcomeLabel(with name: String) {
        let string = "\(name) 님,\n안녕하세요~!"
        let attributedString = NSMutableAttributedString(string: string)

        if let nameRange = string.range(of: "\(name)") {
            let nsRange = NSRange(nameRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: nsRange)
        }

        if let otherTextRange = string.range(of: " 님,\n안녕하세요~!") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }

        welcomeLabel.attributedText = attributedString
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        setupNev()
        layout()
                
        sadButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                print("findIdButton")
                self.navigationController?.pushViewController(SurveyViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        profileEditButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                let editProfileVC = EditProfileViewController()
                editProfileVC.delegate = self
                self.navigationController?.pushViewController(editProfileVC, animated: true)
            }).disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(buttonDidTap))
        navigationItem.rightBarButtonItem?.tintColor = MintKitAsset.Colors.mainColor.color
    }
    
    @objc func buttonDidTap() {
        self.dismiss(animated: true)
    }
    
    
    func setupNev() {
        let leftItem = UIBarButtonItem(customView: navLabel)
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftSpace.width = 15
        
        self.navigationItem.leftBarButtonItems = [leftSpace, leftItem]
        self.navigationItem.leftItemsSupplementBackButton = true
    }
    
    func layout() {
        view.addSubview(welcomeLabel)
        view.addSubview(userImageView)
        view.addSubview(sadButton)
        view.addSubview(profileEditButton)
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(46.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        userImageView.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.top)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.width.equalTo(55.0)
        }
        
        sadButton.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(76.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(80.0)
            $0.width.equalTo(360.0)
        }
        
        profileEditButton.snp.makeConstraints {
            $0.top.equalTo(sadButton.snp.bottom).offset(27.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30.0)
            $0.width.equalTo(360.0)
        }
    }
}
