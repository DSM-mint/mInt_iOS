import UIKit
import SnapKit
import Then
import Core
import MintKit
import RxSwift
import RxCocoa

@available(iOS 16.0, *)
public class DiaryViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    lazy var navLabel = UILabel().then {
        $0.textColor = UIColor.white
        $0.text = "일기"
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    private var writingLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        let string = "박준하 님의 기분을 기록해보세요."
        let attributedString = NSMutableAttributedString(string: string)
        
        if let nameRange = string.range(of: "박준하") {
            let nsRange = NSRange(nameRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: nsRange)
        }
        
        if let otherTextRange = string.range(of: " 님의 기분을 기록해보세요.") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }
        
        $0.attributedText = attributedString
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = MintKitAsset.Colors.bkc.color
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private var calendarView = CalendarView()
    private var diaryCollectionView = DiaryCollectionView(frame: .zero)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        stupNev()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonDidTap))
        navigationItem.rightBarButtonItem?.tintColor = MintKitAsset.Colors.mainColor.color
        
        layout()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = MintKitAsset.Colors.bkc.color
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    @objc func buttonDidTap() {
        self.navigationController?.pushViewController(WriteDiaryViewController(), animated: true)
    }
    
    func stupNev() {
        let leftItem = UIBarButtonItem(customView: navLabel)
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftSpace.width = 15
        
        self.navigationItem.leftBarButtonItems = [leftSpace, leftItem]
        self.navigationItem.leftItemsSupplementBackButton = true
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
        
        
        [
            writingLabel,
            calendarView,
            diaryCollectionView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        calendarView.snp.makeConstraints {
            $0.width.equalTo(370.0)
            $0.height.equalTo(450.0)
        }
        
        diaryCollectionView.snp.makeConstraints {
            $0.width.equalTo(370.0)
            $0.height.equalTo(600.0)
        }
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
