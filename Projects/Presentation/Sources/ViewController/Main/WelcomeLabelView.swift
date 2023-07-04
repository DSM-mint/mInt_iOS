//
//  WelcomeLabelView.swift
//  Presentation
//
//  Created by 박준하 on 2023/07/04.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//
import UIKit
import SnapKit
import Then
import Core
import MintKit
import RxSwift
import RxCocoa

class WelcomeLabelView: UIView {
    private final var controller: UIViewController
    
    private var welcomeLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        let string = "박준하 님,\n오늘 하루는 어떠셨나요"
        let attributedString = NSMutableAttributedString(string: string)

        if let nameRange = string.range(of: "박준하") {
            let nsRange = NSRange(nameRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: nsRange)
        }

        if let otherTextRange = string.range(of: " 님,\n오늘 하루는 어떠셨나요") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }

        $0.attributedText = attributedString
    }
    
    init(frame: CGRect ,viewController: UIViewController) {
        self.controller = viewController
        super.init(frame: frame)
        
        layout()
    }
    
    func layout() {
        [
            welcomeLabel
        ].forEach { self.addSubview($0) }
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(25.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
