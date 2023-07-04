//
//  SignUpViewController.swift
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

public class SignUpViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private var userImageView = AddPictureView(titleText: "사진 추가하기")
    
    private var mintFourTextField = MintFourTextField(placeholder1: "이름을 입력해주세요.", placeholder2: "아이디를 입력해주세요.", placeholder3: "이메일을 입력해주세요.", placeholder4: "비밀번호를 입력해주세요.")
    
    private var signUpButton = MintButton(buttonTitle: "가입하기", titleColor: .white)
   
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "회원가입"
        
        view.addSubview(userImageView)
        view.addSubview(mintFourTextField)
        view.addSubview(signUpButton)
        
        userImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(105.0)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(140.0)
        }
        
        mintFourTextField.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(270.0)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(mintFourTextField.snp.bottom).offset(40.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(370.0)
            $0.height.equalTo(54.0)
        }
    }
}
