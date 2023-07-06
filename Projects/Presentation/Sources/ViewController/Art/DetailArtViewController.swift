//
//  DetailArtViewController.swift
//  MintKit
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

public class DetailArtViewController: UIViewController {
    
    var disposebag = DisposeBag()
    
    var imageView = UIImageView().then {
        $0.image = MintKitAsset.Assets.asdfImage1.image
    }
    
    var subTitle = UILabel().then {
        $0.textColor = .white
        $0.text = "계속 듣고 싶은 콘서트 😃"
        $0.font = .systemFont(ofSize: 18.0, weight: .regular)
    }
    
    var mainTitle = UILabel().then {
        $0.textColor = .white
        $0.text = "카더가든 콘서트"
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    var periodTitle = UILabel().then {
        $0.textColor = .white
        $0.text = "기간"
        $0.font = .systemFont(ofSize: 18.0, weight: .bold)
    }
    
    var periodDetailTitle = UILabel().then {
        $0.textColor = MintKitAsset.Colors.gary500.color
        $0.text = "2023년 6월 24일 ~ 2023년 6월 28일"
        $0.font = .systemFont(ofSize: 16.0, weight: .bold)
    }
    
    var linkTitle = UILabel().then {
        $0.textColor = .white
        $0.text = "링크"
        $0.font = .systemFont(ofSize: 18.0, weight: .bold)
    }
    
    var linkDetailTitle = UILabel().then {
        $0.textColor = MintKitAsset.Colors.gary500.color
        $0.text = "https://www.youtube.com/results"
        $0.font = .systemFont(ofSize: 16.0, weight: .bold)
    }
    
    var suggestionCollectionView: MintCollectionView!
    
    var suggestionTitle = UILabel().then {
        $0.textColor = .white
        $0.text = "이건 어떠세요? 🥳"
        $0.font = .systemFont(ofSize: 18.0, weight: .bold)
    }
    
    let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.backgroundColor = MintKitAsset.Colors.bkc.color
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()
    
    let contentView = UIView()
    
    public init(mainTitleText: String, subTitleText: String, imageView: UIImage) {
        super.init(nibName: nil, bundle: nil)
        
        self.mainTitle.text = mainTitleText
        self.subTitle.text = subTitleText
        self.imageView.image = imageView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = MyModel.getModified()
        suggestionCollectionView = MintCollectionView(dataSource: dataSource)
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        suggestionCollectionView.delegate = self
        
        layout()
    }
    
    func layout() {
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 60
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
            imageView,
            subTitle,
            mainTitle,
            periodTitle,
            periodDetailTitle,
            linkTitle,
            linkDetailTitle,
            suggestionTitle,
            suggestionCollectionView
        ].forEach { stackView.addArrangedSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(-50.0)
            $0.height.equalTo(220.0)
        }
        
        subTitle.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(-30.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(6.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        periodTitle.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(60.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        periodDetailTitle.snp.makeConstraints {
            $0.top.equalTo(periodTitle.snp.bottom).offset(6.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        linkTitle.snp.makeConstraints {
            $0.top.equalTo(periodDetailTitle.snp.bottom).offset(60.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        linkDetailTitle.snp.makeConstraints {
            $0.top.equalTo(linkTitle.snp.bottom).offset(6.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        suggestionTitle.snp.makeConstraints {
            $0.top.equalTo(linkDetailTitle.snp.bottom).offset(60.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        suggestionCollectionView.snp.remakeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(suggestionTitle.snp.bottom)
            $0.height.equalTo(580.0)
            $0.bottom.equalToSuperview()
        }
    }
}

extension DetailArtViewController: MintCollectionViewDelegate {
    
    public func didSelectItemAt(_ collectionView: MintKit.MintCollectionView, indexPath: IndexPath) {
        print(indexPath.row)
        self.modalPresentationStyle = .fullScreen
        
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
