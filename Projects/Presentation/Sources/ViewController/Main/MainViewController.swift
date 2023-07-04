//
//  MainViewController.swift
//  Presentation
//
//  Created by 박준하 on 2023/07/04.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import Foundation
import UIKit
import MintKit

public class MainViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNev()
        setup()
    }
    
    func setup() {
        view.backgroundColor = MintKitAsset.Colors.bkc.color
    }
    
    func setupNev() {
        let image = MintKitAsset.Assets.mintLogo.image
        
        let resizedImage = image.resized(toWidth: 73, height: 28)
        let button = UIButton(type: .custom)
        button.setImage(resizedImage, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 73, height: 28)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func buttonTapped() {
        print("안녕")
    }

}

extension UIImage {
    func resized(toWidth width: CGFloat, height: CGFloat) -> UIImage? {
        let newSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func roundedImage(withRadius radius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        let bounds = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: bounds, cornerRadius: radius).addClip()
        draw(in: bounds)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
