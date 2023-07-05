//
//  InfoCollectionViewCell.swift
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

class DiaryCollectionViewCell: UICollectionViewCell {
    
    static var id: String = "DiaryCollectionViewCell"
    
    private var imageView = UIImageView().then {
        $0.image = MintKitAsset.Assets.testImage2.image
        $0.layer.cornerRadius = 10.0
    }
    
    private var dateTitle = UILabel().then {
        $0.text = "2023.6.26"
        $0.textColor = MintKitAsset.Colors.gary300.color
        $0.font = .systemFont(ofSize: 12.0, weight: .bold)
    }
    
    private var mainTitle = UILabel().then {
        $0.text = "오늘은 이거 한 날"
        $0.textColor = MintKitAsset.Colors.gary000.color
        $0.font = .systemFont(ofSize: 15.0, weight: .bold)
    }
    
    private var subTitle = UILabel().then {
        $0.text = "오늘은 이거를 했습니다. 기분은 별로 였는데요"
        $0.textColor =  MintKitAsset.Colors.gary400.color
        $0.font = .systemFont(ofSize: 13.0, weight: .bold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.layer.cornerRadius = 10.0
        
        contentView.backgroundColor = MintKitAsset.Colors.gary800.color
        contentView.addSubview(imageView)
        contentView.addSubview(dateTitle)
        contentView.addSubview(mainTitle)
        contentView.addSubview(subTitle)
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(80.0)
            $0.leading.equalToSuperview().offset(14.0)
        }
        
        dateTitle.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top)
            $0.leading.equalTo(imageView.snp.trailing).offset(14.0)
        }
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(dateTitle.snp.bottom).offset(10.0)
            $0.leading.equalTo(dateTitle.snp.leading)
        }
        
        subTitle.snp.makeConstraints {
            $0.leading.equalTo(mainTitle.snp.leading)
            $0.trailing.equalToSuperview().inset(10.0)
            $0.bottom.equalTo(imageView.snp.bottom).inset(8.0)
        }
    }
}
