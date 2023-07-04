//
//  ArtViewController.swift
//  Presentation
//
//  Created by 박준하 on 2023/07/05.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Core
import MintKit
import RxSwift
import RxCocoa

public class ArtViewController: UIViewController {
    
    var disposebag = DisposeBag()
    
    lazy var navLabel = UILabel().then {
        $0.textColor = UIColor.white
        $0.text = "예술"
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    var concertCollectionView: MintCollectionView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let dataSource = MyModel.getModified()
        concertCollectionView = MintCollectionView(dataSource: dataSource)
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        layout()
        setNav()
    }
    
    func layout() {
        [
            concertCollectionView
        ].forEach { view.addSubview($0) }
        
        concertCollectionView!.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(650.0)
        }
    }
    
    func setNav() {
        let leftItem = UIBarButtonItem(customView: navLabel)
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftSpace.width = 15
        
        self.navigationItem.leftBarButtonItems = [leftSpace, leftItem]
        self.navigationItem.leftItemsSupplementBackButton = true
    }
}
