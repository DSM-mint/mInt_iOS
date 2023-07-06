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
    
    private var welcomeLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        let string = "박준하 님,\n이런 경험은 어떠세요?"
        let attributedString = NSMutableAttributedString(string: string)
        
        if let nameRange = string.range(of: "박준하") {
            let nsRange = NSRange(nameRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: nsRange)
        }
        
        if let otherTextRange = string.range(of: " 님,\n이런 경험은 어떠세요?") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }
        
        $0.attributedText = attributedString
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
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
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
        
        concertCollectionView.delegate = self
        musicalView.delegate = self
        theaterView.delegate = self
        exhibitionView.delegate = self
        
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
            welcomeLabel,
            titleLabel1,
            concertCollectionView,
            
            titleLabel2,
            musicalView,
            
            titleLabel3,
            theaterView,
            
            titleLabel4,
            exhibitionView
            
        ].forEach { stackView.addArrangedSubview($0) }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        titleLabel1.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(14.0)
            $0.left.equalToSuperview().offset(30.0)
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

extension ArtViewController: MintCollectionViewDelegate {
    
    public func didSelectItemAt(_ collectionView: MintKit.MintCollectionView, indexPath: IndexPath) {
        print(indexPath.row)
        self.modalPresentationStyle = .fullScreen
        
        if collectionView == concertCollectionView {
            switch indexPath.row {
            case 0:
                let vc = DetailArtViewController(mainTitleText: "카더가든 콘서트", subTitleText: "계속 듣고 싶은 콘서트 😃", imageView: MintKitAsset.Assets.asdfImage1.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = DetailArtViewController(mainTitleText: "10cm 콘서트", subTitleText: "사랑을 전해보는 콘서트 💋", imageView: MintKitAsset.Assets.asdfImage4.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = DetailArtViewController(mainTitleText: "라우브 내한공연", subTitleText: "티켓팅이 어려운 콘서트 🤬", imageView: MintKitAsset.Assets.asdfImage2.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = DetailArtViewController(mainTitleText: "찰리푸스 콘서트", subTitleText: "찌질한 전남친 컨셉 콘서트 🥺", imageView: MintKitAsset.Assets.asdfImage3.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("asdf")
            }
        }
        if collectionView == musicalView {
            switch indexPath.row {
            case 0:
                let vc = DetailArtViewController(mainTitleText: "카더가든 콘서트", subTitleText: "계속 듣고 싶은 콘서트 😃", imageView: MintKitAsset.Assets.asdfImage1.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = DetailArtViewController(mainTitleText: "10cm 콘서트", subTitleText: "사랑을 전해보는 콘서트 💋", imageView: MintKitAsset.Assets.asdfImage4.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = DetailArtViewController(mainTitleText: "라우브 내한공연", subTitleText: "티켓팅이 어려운 콘서트 🤬", imageView: MintKitAsset.Assets.asdfImage2.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = DetailArtViewController(mainTitleText: "찰리푸스 콘서트", subTitleText: "찌질한 전남친 컨셉 콘서트 🥺", imageView: MintKitAsset.Assets.asdfImage3.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("asdf")
            }
        }
        
        if collectionView == theaterView {
            switch indexPath.row {
            case 0:
                let vc = DetailArtViewController(mainTitleText: "카더가든 콘서트", subTitleText: "계속 듣고 싶은 콘서트 😃", imageView: MintKitAsset.Assets.asdfImage1.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = DetailArtViewController(mainTitleText: "10cm 콘서트", subTitleText: "사랑을 전해보는 콘서트 💋", imageView: MintKitAsset.Assets.asdfImage4.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = DetailArtViewController(mainTitleText: "라우브 내한공연", subTitleText: "티켓팅이 어려운 콘서트 🤬", imageView: MintKitAsset.Assets.asdfImage2.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = DetailArtViewController(mainTitleText: "찰리푸스 콘서트", subTitleText: "찌질한 전남친 컨셉 콘서트 🥺", imageView: MintKitAsset.Assets.asdfImage3.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("asdf")
            }
        }
        
        if collectionView == exhibitionView {
            switch indexPath.row {
            case 0:
                let vc = DetailArtViewController(mainTitleText: "카더가든 콘서트", subTitleText: "계속 듣고 싶은 콘서트 😃", imageView: MintKitAsset.Assets.asdfImage1.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = DetailArtViewController(mainTitleText: "10cm 콘서트", subTitleText: "사랑을 전해보는 콘서트 💋", imageView: MintKitAsset.Assets.asdfImage4.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = DetailArtViewController(mainTitleText: "라우브 내한공연", subTitleText: "티켓팅이 어려운 콘서트 🤬", imageView: MintKitAsset.Assets.asdfImage2.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = DetailArtViewController(mainTitleText: "찰리푸스 콘서트", subTitleText: "찌질한 전남친 컨셉 콘서트 🥺", imageView: MintKitAsset.Assets.asdfImage3.image)
                
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("asdf")
            }
        }
       
    }
    
}
