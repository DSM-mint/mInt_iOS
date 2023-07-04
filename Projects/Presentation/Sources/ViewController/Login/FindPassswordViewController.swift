//
//  FindPassswordViewController.swift
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

public class FindPassswordViewController: BaseFindVC {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "비밀번호 찾기"
        updateWith(self)
    }
}
