import Foundation

public protocol ModuleFactoryInterface {
    func loginVC() -> LoginViewController
    func mainVC() -> MainViewController
    func findIdVC() -> FindIdViewController
    func findPasswordVC() -> FindPassswordViewController
//    func tabBarVC() -> TapBarViewController
//    func companyListVC() -> CompanyListViewController
}
