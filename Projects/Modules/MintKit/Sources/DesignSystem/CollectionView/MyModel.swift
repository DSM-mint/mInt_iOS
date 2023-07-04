//
//  MyModel.swift
//  MintKit
//
//  Created by 박준하 on 2023/07/05.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import UIKit

public struct MyModel {
    let color: UIColor
    let commentString: String
    let contentSize: CGSize

    public static func getModified() -> [Self] {

        var datas: [MyModel] = []

        for i in 0..<4 {
            let red: CGFloat = 0.5
            let green: CGFloat = 0.5
            let blue: CGFloat = 0.5
            let alpha: CGFloat = 1.0

            let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            let width: CGFloat = 180

            var height: CGFloat = 220
            if i == 1 {
                height = 280
            }

            let myModel: MyModel = .init(color: color,
                                         commentString: "\(i + 1) cell",
                                         contentSize: CGSize(width: width, height: height))
            datas += [myModel]
        }

        return datas
    }
}
