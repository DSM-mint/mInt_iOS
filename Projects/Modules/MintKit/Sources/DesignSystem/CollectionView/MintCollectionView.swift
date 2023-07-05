import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core

public protocol MintCollectionViewDelegate: AnyObject {
    func didSelectItemAt(_ collectionView: MintCollectionView, indexPath: IndexPath)
}

open class MintCollectionView: UIView {
    
    public weak var delegate: MintCollectionViewDelegate?
    
    var collectionView: UICollectionView!
    var dataSource: [MyModel] = []
    
    required public init(dataSource: [MyModel]) {
        self.dataSource = dataSource
        super.init(frame: .zero)
        
        self.setupDataSource()

        self.configure()
        self.collectionView.isScrollEnabled = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDataSource() {
        dataSource = MyModel.getModified()
    }
    
    private func configure() {

        let collectionViewLayout = MyLayout()
        collectionViewLayout.delegate = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.layer.borderWidth = 1
        collectionView.backgroundColor = MintKitAsset.Colors.bkc.color
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        self.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(10)
            $0.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(-10)
            $0.height.equalTo(550)
        }

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.id)
    }
}

extension MintCollectionView: MyCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.item].contentSize.height
    }
}

extension MintCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dataSource.count)
        return dataSource.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.id, for: indexPath)
        if let cell = cell as? MyCell {
            cell.myModel = dataSource[indexPath.item]
            if indexPath.row == 0 {
                cell.titleLabel.text = "카더가든 콘서트"
                cell.containerView.image = MintKitAsset.Assets.testImage1.image
            } else if indexPath.row == 1 {
                cell.titleLabel.text = "10cm 콘서트"
                cell.containerView.image = MintKitAsset.Assets.testImage2.image
            } else if indexPath.row == 2 {
                cell.titleLabel.text = "라우브 내한공연"
                cell.containerView.image = MintKitAsset.Assets.testImage3.image
            } else if indexPath.row == 3 {
                cell.titleLabel.text = "찰리푸스 콘서트"
                cell.containerView.image = MintKitAsset.Assets.testImage4.image
            }
        }
        return cell
    }
}

extension MintCollectionView {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(self, indexPath: indexPath)
    }
}
