import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core
import MintKit

public class DiaryCollectionView: UIView {
    weak var delegate: DiaryCollectionViewDelegate?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.layout()
        self.setupCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.layout()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(DiaryCollectionViewCell.self, forCellWithReuseIdentifier: DiaryCollectionViewCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = MintKitAsset.Colors.bkc.color
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
    }
    
    func layout() {
        self.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }
}


extension DiaryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCollectionViewCell.id, for: indexPath) as? DiaryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.layout()
        cell.layer.cornerRadius = 9.25
        
        let m = cell.mainTitle
        let s = cell.subTitle
        var i = cell.imageView.image
        
        switch indexPath.row {
        case 0:
            m.text = "잠 못드는 날"
            s.text = "해커톤이 나를 이렇게 만들었어!"
            i = MintKitAsset.Assets.testImage2.image
        case 1:
            m.text = "깃허브 커밋 못한 날"
            s.text = "실수로 커밋을 하지 못하였다.."
            i = MintKitAsset.Assets.testImage2.image
        case 2:
            m.text = "해커톤 발표 날"
            s.text = "하하"
            i = MintKitAsset.Assets.paintingLogo.image
        default:
            print("없음")
        }
        
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.diaryCollectionView(self, didSelectItemAt: indexPath)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}
