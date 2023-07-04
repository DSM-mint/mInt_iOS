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
    
    var titleLabel1 = UILabel().then {
        $0.text = "콘서트"
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.textColor = MintKitAsset.Colors.mainColor.color
    }
    
    var titleLabel2 = UILabel().then {
        $0.text = "뮤지컬"
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.textColor = MintKitAsset.Colors.mainColor.color
    }

    var titleLabel3 = UILabel().then {
        $0.text = "연극"
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.textColor = MintKitAsset.Colors.mainColor.color
    }
    
    var titleLabel4 = UILabel().then {
        $0.text = "전시"
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.textColor = MintKitAsset.Colors.mainColor.color
    }
    
    let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.backgroundColor = MintKitAsset.Colors.bkc.color
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()
    
    var concertCollectionView: MintCollectionView!
    var musicalView: MintCollectionView!
    var theaterView: MintCollectionView!
    var exhibitionView: MintCollectionView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let dataSource = MyModel.getModified()
        concertCollectionView = MintCollectionView(dataSource: dataSource)
        musicalView = MintCollectionView(dataSource: dataSource)
        theaterView = MintCollectionView(dataSource: dataSource)
        exhibitionView = MintCollectionView(dataSource: dataSource)
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        
        navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barTintColor = MintKitAsset.Colors.bkc.color
            navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        
        layout()
        setNav()
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
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.centerX.equalTo(scrollView)
        }
        
        [
            titleLabel1,
            concertCollectionView,
            
            titleLabel2,
            musicalView,
            
            titleLabel3,
            theaterView,
            
            titleLabel4,
            exhibitionView
            
        ].forEach { stackView.addArrangedSubview($0) }
        
        titleLabel1.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        concertCollectionView!.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(titleLabel1.snp.bottom)
            $0.height.equalTo(580.0)
        }
        
        titleLabel2.snp.makeConstraints {
            $0.top.equalTo(concertCollectionView.snp.bottom)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        musicalView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(titleLabel2.snp.bottom)
            $0.height.equalTo(580.0)
        }
        
        titleLabel3.snp.makeConstraints {
            $0.top.equalTo(musicalView.snp.bottom)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        theaterView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(titleLabel3.snp.bottom)
            $0.height.equalTo(580.0)
        }
        
        titleLabel4.snp.makeConstraints {
            $0.top.equalTo(theaterView.snp.bottom)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        exhibitionView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(titleLabel4.snp.bottom)
            $0.height.equalTo(580.0)
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
