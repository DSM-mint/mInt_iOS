import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core

open class MintCollectionView: UIView {
    
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
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        self.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 550).isActive = true

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
        }
        return cell
    }
}
