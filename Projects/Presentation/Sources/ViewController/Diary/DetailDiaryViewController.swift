import UIKit
import SnapKit
import Then
import Core
import MintKit
import RxSwift
import RxCocoa
import Foundation

public class DetailDiaryViewController: UIViewController {
    
    var mainImageView = UIImageView().then {
        $0.image = MintKitAsset.Assets.testImage2.image
        $0.layer.cornerRadius = 10.0
    }
    
    var mainTitle = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.text = "오늘은 이거 한 날"
    }
    
    var subTitle = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 16.0, weight: .thin)
        $0.text = "오늘은 전시회를 다녀왔는데 \n제가 좋아하는 작가의 작품이 있어서 너무 좋았습니다.\n\n내년에 한 번 더 전시회 진행하면 가보려구요"
    }
    
    var tagList: [String] = [
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
    
    public init(mainTitleText: String, mainImage: UIImage, subTitleText: String, tagList: [String]) {
        super.init(nibName: nil, bundle: nil)
        
        self.mainTitle.text = mainTitleText
        self.mainImageView.image = mainImage
        self.subTitle.text = subTitleText
        self.tagList = tagList
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "일기"
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        layout()
    }
    
    func layout() {
        [
            mainImageView,
            mainTitle,
            subTitle,
            collectionView
        ].forEach { view.addSubview($0) }
        
        mainImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.width.height.equalTo(140.0)
        }
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(40.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        subTitle.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(12.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(200)
        }
    }
}

@available(iOS 16.0, *)
extension DetailDiaryViewController: UICollectionViewDataSource {
    
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
extension DetailDiaryViewController: UICollectionViewDelegateFlowLayout {
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
