//
//  SurveyView.swift
//  MintKit
//
//  Created by 박준하 on 2023/07/04.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

open class SurveyView: UIView {
    
    public var titleLabel = UILabel().then {
        $0.text = "아무렇지도 않던 일들이 괴롭고\n귀찮게 느껴져요 "
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    let button1 = UIButton().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 40
        $0.layer.borderWidth = 3
        $0.layer.borderColor = MintKitAsset.Colors.error.color.cgColor
    }
    
    let button2 = UIButton().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 30
        $0.layer.borderWidth = 3
        $0.layer.borderColor = MintKitAsset.Colors.mainColor.color.cgColor
    }
    
    let button3 = UIButton().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 30
        $0.layer.borderWidth = 3
        $0.layer.borderColor = MintKitAsset.Colors.mainColor.color.cgColor
    }
    
    let button4 = UIButton().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 40
        $0.layer.borderWidth = 3
        $0.layer.borderColor = MintKitAsset.Colors.error.color.cgColor
    }
    
    public init(problemText: String) {
        super.init(frame: .zero)
        titleLabel.text = problemText
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(button1)
        self.addSubview(button2)
        self.addSubview(button3)
        self.addSubview(button4)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        
        button1.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(35)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        button2.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.left.equalTo(button1.snp.right).offset(28)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        button3.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.left.equalTo(button2.snp.right).offset(28)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        button4.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.left.equalTo(button3.snp.right).offset(28)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
}
