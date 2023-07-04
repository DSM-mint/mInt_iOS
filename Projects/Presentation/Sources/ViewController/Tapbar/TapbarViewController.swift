//
//  TapbarViewController.swift
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

public class TapbarViewController: UITabBarController {
    
    public var factory: ModuleFactoryInterface!
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homeVC = UINavigationController(rootViewController: MainViewController())
        let tabOneBarItem = UITabBarItem(title: "",
                                         image: MintKitAsset.Assets.mainImage.image,
                                         tag: 1)
        
        homeVC.tabBarItem = tabOneBarItem
        
        let diaryVC = UINavigationController(rootViewController: UIViewController())
        let tabTwoBarItem2 = UITabBarItem(title: "",
                                          image: MintKitAsset.Assets.diaryImage.image,
                                          tag: 2)
        diaryVC.tabBarItem = tabTwoBarItem2
        
        let artVC = UINavigationController(rootViewController: UIViewController())
        let tabThrBarItem3 = UITabBarItem(title: "",
                                          image: MintKitAsset.Assets.artImage.image,
                                          tag: 3)
        
        artVC.tabBarItem = tabThrBarItem3
        
        let userVC = UINavigationController(rootViewController: UserViewController())
        let tabFouBarItem4 = UITabBarItem(title: "",
                                          image: MintKitAsset.Assets.userImage.image,
                                          tag: 4)
        
        userVC.tabBarItem = tabFouBarItem4
        
        self.tabBar.tintColor = MintKitAsset.Colors.mainColor.color
        self.tabBar.backgroundColor = MintKitAsset.Colors.bkc.color
        self.tabBar.unselectedItemTintColor = MintKitAsset.Colors.gary700.color
        self.viewControllers = [homeVC, diaryVC, artVC, userVC]
    }
}
