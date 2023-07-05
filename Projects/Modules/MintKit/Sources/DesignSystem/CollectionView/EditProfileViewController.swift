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

public class EditProfileViewController: UIViewController {
    
    var userImageView = UIImageView().then {
        $0.backgroundColor = MintKitAsset.Colors.gary700.color
        $0.layer.cornerRadius = 10.0
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        [
            userImageView
        ].forEach {
            view.addSubview($0)
        }
        
        userImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(140.0)
        }
    }
}
