//
//  ChangePasswordViewController.swift
//  Presentation
//
//  Created by 박준하 on 2023/07/05.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import Then
import Core
import MintKit
import RxSwift
import RxCocoa
import UIKit

public class ChangePasswordViewController: UIViewController {
    
    var passwordTextFieldView = MintTwoTextField(placeholder1: "새로운 비밀번호를 입력하세요", placeholder2: "비밀번호 확인")
    var passwordResetButton = MintButton(buttonTitle: "비밀번호 재설정", titleColor: .white)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        layout()
    }
    
    func layout() {
        view.addSubview(passwordTextFieldView)
        view.addSubview(passwordResetButton)
        
        passwordTextFieldView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80.0)
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(130.0)
        }
        
        passwordResetButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextFieldView.snp.bottom).offset(28.0)
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
        }
    }
}
