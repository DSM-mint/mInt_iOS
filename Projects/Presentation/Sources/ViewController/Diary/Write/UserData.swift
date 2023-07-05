//
//  UserData.swift
//  Presentation
//
//  Created by 박준하 on 2023/07/06.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import UIKit

public struct UserData: Codable {
    var title: String = ""
    var content: String = ""
    var moodTags: [String] = []
    var imageData: Data?
}
