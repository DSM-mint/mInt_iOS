//
//  TagCell.swift
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


class TagCell: UICollectionViewCell {
    
    static var id: String = "TagCell"
    
    let tagLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = MintKitAsset.Colors.mainColor.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(tagLabel)
        contentView.backgroundColor = MintKitAsset.Colors.bkc.color
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = MintKitAsset.Colors.mainColor.color.cgColor
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 15
        
        setConstraint()
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }

    func setConstraint() {
        tagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func updateSelectedState() {
        if isSelected {
            contentView.backgroundColor = MintKitAsset.Colors.mainColor.color
            tagLabel.textColor = MintKitAsset.Colors.bkc.color
        } else {
            contentView.backgroundColor = MintKitAsset.Colors.bkc.color
            tagLabel.textColor = MintKitAsset.Colors.mainColor.color
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
