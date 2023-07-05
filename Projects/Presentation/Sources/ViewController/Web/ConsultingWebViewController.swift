//
//  consultingWebViewController.swift
//  Presentation
//
//  Created by 박준하 on 2023/07/04.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import UIKit
import WebKit

class ConsultingWebViewController: BaseWebView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "상담"
        self.navigationItem.largeTitleDisplayMode = .never
        if let url = URL(string: "https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwitkqmIj_X_AhWm1RYFHeB8BCsYABAAGgJ0bA&ae=2&ohost=www.google.com&cid=CAESbeD27mtNCQOXE0uMYrxqA9MqZFpl6lCxhmeCiUS2WyB2VbH4xBrWY1Jdg6iOohojsdPmoDxNqQDLJZkz7imAZ7UZ6y_NUCjETDhNM4cZ0qJJmSH18_hzDntZmOAxMIvHa1-qCJerJQRqk9fGd6w&sig=AOD64_2FoKusWuTISGO3NUtUhcN9cRsrqw&q&adurl&ved=2ahUKEwj10KGIj_X_AhXYU94KHaNUDIEQ0Qx6BAgFEAE&nis=2&dct=1") {
            setupWebView(with: url)
        }
    }
}

class ParkWebViewController: BaseWebView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "공원"
        self.navigationItem.largeTitleDisplayMode = .never
        if let url = URL(string: "https://www.tripadvisor.co.kr/Attractions-g297887-Activities-c57-Daejeon.html") {
            setupWebView(with: url)
        }
    }
}
