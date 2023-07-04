import UIKit
import SnapKit
import Then
import Core
import MintKit
import RxSwift
import RxCocoa

public class MainViewController: UIViewController {
    
    let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.backgroundColor = MintKitAsset.Colors.bkc.color
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()

    private var welcomeLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        let string = "박준하 님,\n오늘 하루는 어떠셨나요"
        let attributedString = NSMutableAttributedString(string: string)

        if let nameRange = string.range(of: "박준하") {
            let nsRange = NSRange(nameRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: nsRange)
        }

        if let otherTextRange = string.range(of: " 님,\n오늘 하루는 어떠셨나요") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }

        $0.attributedText = attributedString
    }

    private var calendarView = UIView().then {
        $0.backgroundColor = MintKitAsset.Colors.gary800.color
        $0.layer.cornerRadius = 16.0
    }
    
    private var calendarView1 = UIView().then {
        $0.backgroundColor = MintKitAsset.Colors.gary800.color
        $0.layer.cornerRadius = 16.0
    }
    
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

        setupNev()
        setup()
        layout()
        
        tabBarController?.tabBar.barTintColor = MintKitAsset.Colors.bkc.color
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = MintKitAsset.Colors.bkc.color
    }

    func layout() {
        
        self.view.addSubview(scrollView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
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
        
        stackView.addArrangedSubview(artLabel)
        
        stackView.addArrangedSubview(calendarView1)
        calendarView1.snp.makeConstraints {
            $0.width.equalTo(370.0)
            $0.height.equalTo(450.0)
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
