//
//  ModuleFactoryInterface.swift
//  Presentation
//
//  Created by 박준하 on 2023/07/03.
//  Copyright © 2023 APP-iOS. All rights reserved.
//
import Foundation

public protocol ModuleFactoryInterface {
    func loginVC() -> LoginViewController
    func mainVC() -> MainViewController
    func findIdVC() -> FindIdViewController
    func findPasswordVC() -> FindPassswordViewController
//    func tabBarVC() -> TapBarViewController
//    func companyListVC() -> CompanyListViewController
}
