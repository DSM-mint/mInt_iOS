import UIKit
import SnapKit
import Then
import Core
import MintKit
import RxSwift
import RxCocoa

@available(iOS 16.0, *)
public class MainViewController: UIViewController, UserViewControllerDelegate {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = MintKitAsset.Colors.bkc.color
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private var welcomeLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        let string = "\(name) 님,\n오늘 하루는 어떠셨나요"
        let attributedString = NSMutableAttributedString(string: string)
        
        if let nameRange = string.range(of: "\(name)") {
            let nsRange = NSRange(nameRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: nsRange)
        }
        
        if let otherTextRange = string.range(of: " 님,\n오늘 하루는 어떠셨나요") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }
        
        $0.attributedText = attributedString
    }
    
    private var calendarView = CalendarView()
    var concertCollectionView: MintCollectionView!
    
    private var artLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        let string = "전시 관람으로\n마음을 치유해보세요."
        let attributedString = NSMutableAttributedString(string: string)
        
        if let nameRange = string.range(of: "전시 관람") {
            let nsRange = NSRange(nameRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: nsRange)
        }
        
        if let otherTextRange = string.range(of: "으로\n마음을 치유해보세요.") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }
        
        $0.attributedText = attributedString
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = MyModel.getModified()
        concertCollectionView = MintCollectionView(dataSource: dataSource)
        concertCollectionView.collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        concertCollectionView.collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(550)
        }
        let editProfileVC = EditProfileViewController()
        editProfileVC.delegate = self
        setupNev()
        setup()
        layout()
        
        concertCollectionView.delegate = self
        tabBarController?.tabBar.barTintColor = MintKitAsset.Colors.bkc.color
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = MintKitAsset.Colors.bkc.color
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
    
    
    func layout() {
        
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        let sView = UIView()
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(25.0)
            $0.bottom.equalTo(scrollView).offset(-25.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().offset(-30.0)
        }
        
        stackView.addArrangedSubview(welcomeLabel)
        
        stackView.addArrangedSubview(calendarView)
        calendarView.snp.makeConstraints {
            $0.width.equalTo(370.0)
            $0.height.equalTo(450.0)
        }
        stackView.addArrangedSubview(sView)
        sView.snp.makeConstraints{
            $0.height.equalTo(30.0)
        }
        
        stackView.addArrangedSubview(artLabel)
        
        stackView.addArrangedSubview(concertCollectionView)
        concertCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(600.0)
        }
    }
    
    
    func setup() {
        view.backgroundColor = MintKitAsset.Colors.bkc.color
    }
    
    func setupNev() {
        let image = MintKitAsset.Assets.mintLogo.image
        
        let resizedImage = image.resized(toWidth: 73, height: 28)
        let button = UIButton(type: .custom)
        button.setImage(resizedImage, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.frame = CGRect(x: 0, y: 0, width: 73, height: 28)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func buttonTapped() {
        print("안녕")
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
}

extension UIImage {
    func resized(toWidth width: CGFloat, height: CGFloat) -> UIImage? {
        let newSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func roundedImage(withRadius radius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        let bounds = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: bounds, cornerRadius: radius).addClip()
        draw(in: bounds)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


@available(iOS 16.0, *)
extension MainViewController: MintCollectionViewDelegate {
    
    public func didSelectItemAt(_ collectionView: MintKit.MintCollectionView, indexPath: IndexPath) {
        print(indexPath.row)
        self.modalPresentationStyle = .fullScreen
        
        switch indexPath.row {
        case 0:
            let vc = DetailArtViewController(mainTitleText: "카더가든 콘서트", subTitleText: "계속 듣고 싶은 콘서트 😃", imageView: MintKitAsset.Assets.asdfImage1.image)
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = DetailArtViewController(mainTitleText: "10cm 콘서트", subTitleText: "사랑을 전해보는 콘서트 💋", imageView: MintKitAsset.Assets.asdfImage4.image)
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = DetailArtViewController(mainTitleText: "라우브 내한공연", subTitleText: "티켓팅이 어려운 콘서트 🤬", imageView: MintKitAsset.Assets.asdfImage2.image)
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = DetailArtViewController(mainTitleText: "찰리푸스 콘서트", subTitleText: "찌질한 전남친 컨셉 콘서트 🥺", imageView: MintKitAsset.Assets.asdfImage3.image)
            
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("asdf")
        }
    }
    
}
