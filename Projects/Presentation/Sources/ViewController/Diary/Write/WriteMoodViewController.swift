//
//  WriteMoodViewController.swift
//  Presentation
//
//  Created by 박준하 on 2023/07/05.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core
import MintKit

public class WriteMoodViewController: UIViewController {
    
    let tagList: [String] = [
        "개발자아라찌",
        "Then",
        "SnapKit",
        "RxSwift",
        "Viper",
        "Swift",
        "UIKit",
        "Foundation",
        "ReactorKit"
    ]
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
        $0.backgroundColor = .systemBackground
        $0.register(TagCell.self, forCellWithReuseIdentifier: TagCell.id)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        
        self.view.addSubview(collectionView)
        
        setConstraint()
        self.collectionView.dataSource = self
    }
    
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
    
    func setConstraint() {
        collectionView.snp.makeConstraints {
            $0.center.width.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}

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
        print(indexPath.row)
    }
}

extension WriteMoodViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 14)
            $0.text = tagList[indexPath.item]
            $0.sizeToFit()
        }
        let size = label.frame.size
        
        return CGSize(width: size.width + 16, height: size.height + 10)
    }
}
