import Foundation

public protocol ModuleFactoryInterface {
    func loginVC() -> LoginViewController
    func mainVC() -> MainViewController
    func findIdVC() -> FindIdViewController
    func findPasswordVC() -> FindPassswordViewController
    func signUpVC() -> SignUpViewController
    func tapbarVC() -> TapbarViewController
    func surveyVC() -> SurveyViewController
    func resultVC() -> ResultViewController
    func diaryVC() -> DiaryViewController
    func artVC() -> ArtViewController
//    func tabBarVC() -> TapBarViewController
//    func companyListVC() -> CompanyListViewController
}
