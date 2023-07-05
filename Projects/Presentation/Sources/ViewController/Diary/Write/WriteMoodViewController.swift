import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core
import MintKit


//2
@available(iOS 16.0, *)
public class WriteMoodViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private var moodTitle = UILabel().then {
        $0.text = "오늘 기분은 어떠세요?"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    private var moodAddTitle = UILabel().then {
        $0.text = "오늘 기분은 어떠세요?"
        $0.textColor = MintKitAsset.Colors.gary300.color
        $0.font = .systemFont(ofSize: 16.0, weight: .bold)
    }
    
    private var moodAddButton = UIButton().then {
        $0.setTitle("감정 추가하기", for: .normal)
        $0.setTitleColor(MintKitAsset.Colors.gary300.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
    }
    
    private var backButton = MintButton(buttonTitle: "이전 단계", titleColor: MintKitAsset.Colors.mainColor.color, backgroud: .white)
    private var nextButton = MintButton(buttonTitle: "다음 단계", titleColor: .white)
    
    private let progressBarView = ProgressBarView()

    let tagList: [String] = [
        "기뻐요",
        "슬퍼요",
        "행복해요",
        "즐거워요",
        "분해요",
        "기대돼요",
        "걱정돼요",
        "실망스러워요",
        "억울해요",
        "감동적이에요"
    ]
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 18
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
        $0.backgroundColor = MintKitAsset.Colors.bkc.color
        $0.register(TagCell.self, forCellWithReuseIdentifier: TagCell.id)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        title = "일기 작성하기"
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        layout()
        
        var timer = 0.0
        let finish = 3.0
        timer += 2
        self.progressBarView.ratio = timer / finish
        collectionView.allowsMultipleSelection = true
        
        nextButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                self.navigationController?.pushViewController(WriteImageViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                for viewController in viewControllerStack {
                  if let bView = viewController as? WriteDiaryViewController {
                    self.navigationController?.popToViewController(bView, animated: true)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
    
    func layout() {
        view.addSubview(moodTitle)
        view.addSubview(progressBarView)
        self.view.addSubview(collectionView)
        view.addSubview(moodAddTitle)
        view.addSubview(moodAddButton)
        view.addSubview(backButton)
        view.addSubview(nextButton)
        
        moodTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        progressBarView.snp.makeConstraints {
            $0.top.equalTo(moodTitle.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(4.0)
            $0.width.equalTo(370.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(35.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(200)
        }
        
        moodAddTitle.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(280.0)
            $0.leading.equalToSuperview().offset(100.0)
        }
        //나중에 스택으로 묶자
        moodAddButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(274.0)
            $0.leading.equalTo(moodAddTitle.snp.trailing).offset(10.0)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(moodAddButton.snp.bottom).offset(12.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.height.equalTo(54.0)
            $0.width.equalTo(180.0)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(moodAddButton.snp.bottom).offset(12.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
            $0.width.equalTo(180.0)
        }
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
   }
}

@available(iOS 16.0, *)
extension WriteMoodViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.id, for: indexPath) as! TagCell
        
        cell.tagLabel.text = tagList[indexPath.item]
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TagCell
        cell?.isSelected = true
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TagCell
        cell?.isSelected = false
    }
}

@available(iOS 16.0, *)
extension WriteMoodViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 14)
            $0.text = tagList[indexPath.item]
            $0.sizeToFit()
        }
        let size = label.frame.size
        
        return CGSize(width: size.width + 34, height: size.height + 15)
    }
}
