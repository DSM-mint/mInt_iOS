//
//  ChangePasswordViewController.swift
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

public class ChangePasswordCertificationViewController: BaseFindVC {
    
    var disposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "비밀번호 변경하기"
        updateWith(self)
        mainButton.setTitle("비밀번호 재설정", for: .normal)
        
        mainButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        mintFindTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80.0)
            
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(72.0)
        }
        
        certificationOneTextField.snp.makeConstraints {
            $0.top.equalTo(mintFindTextField.snp.bottom)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(72.0)
        }
        
        mainButton.snp.makeConstraints {
            $0.top.equalTo(certificationOneTextField.snp.bottom).offset(10.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
        }
        
        paintingLogo.snp.makeConstraints {
            $0.top.equalTo(mainButton.snp.bottom).offset(60.0)
            $0.trailing.equalToSuperview().offset(120.0)
            $0.height.width.equalTo(306.0)
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
   }
}
