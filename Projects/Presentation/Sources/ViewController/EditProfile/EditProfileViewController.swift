//
//  EditProfileViewController.swift
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

public class EditProfileViewController: UIViewController {
    weak var delegate: UserViewControllerDelegate?
    
    var disposeBag = DisposeBag()
    
    var userImageView = UIImageView().then {
        $0.image = MintKitAsset.Assets.logo.image
        $0.layer.cornerRadius = 10.0
        $0.layer.cornerRadius = 10.0
        $0.clipsToBounds = true
    }
    
    var mintThreeTextField = MintThreeTextField(placeholder1: "이름을 입력해주세요.", placeholder2: "비밀번호를 입력해주세요.", placeholder3: "이메일을 입력해주세요.")
    var changePasswordButton = MintButton(buttonTitle: "비밀번호 변경하기", titleColor: .white, backgroud: .clear)
    
    var okButton = MintButton(buttonTitle: "완료", titleColor: .white)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "프로필 수정"
        
        mintThreeTextField.textField1.text = "\(name)"
        mintThreeTextField.textField2.text = "12345678!"
        mintThreeTextField.textField3.text = "goodjunha@gmail.com"
        
        name = mintThreeTextField.textField1.text!
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        
        changePasswordButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
               print("findIdButton")
                self.navigationController?.pushViewController(ChangePasswordCertificationViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        okButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                if let newName = self.mintThreeTextField.textField1.text {
                    self.delegate?.userProfileDataChanged(newName: newName)
                }
                self.dismiss(animated: true, completion: nil)
                guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                for viewController in viewControllerStack {
                    if let bView = viewController as? UserViewController {
                        self.navigationController?.popToViewController(bView, animated: true)
                    }
                }
            }).disposed(by: disposeBag)
        
        layout()
    }
    
    func layout() {
        [
            userImageView,
            mintThreeTextField,
            changePasswordButton,
            okButton
        ].forEach {
            view.addSubview($0)
        }
        
        userImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(140.0)
        }
        
        mintThreeTextField.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(38.0)
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(200.0)
        }
        
        changePasswordButton.snp.makeConstraints {
            $0.top.equalTo(mintThreeTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(50.0)
        }
        
        okButton.snp.makeConstraints {
            $0.top.equalTo(changePasswordButton.snp.bottom).offset(65.0)
            $0.left.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
   }
}
