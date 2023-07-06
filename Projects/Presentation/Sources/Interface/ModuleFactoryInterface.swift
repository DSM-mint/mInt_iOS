import Foundation

@available(iOS 16.0, *)
public protocol ModuleFactoryInterface {
    func loginVC() -> LoginViewController
    func mainVC() -> MainViewController
    func findIdVC() -> FindIdViewController
    func findPasswordVC() -> FindPassswordViewController
    func signUpVC() -> SignUpViewController
    func tapbarVC() -> TapbarViewController
    func surveyVC() -> SurveyViewController
    func resultVC() -> BadResultViewController
    func diaryVC() -> DiaryViewController
    func artVC() -> ArtViewController
//    func detailArtVC() -> DetailArtViewController
    func editProfileVC() -> EditProfileViewController
    func writeDiaryVC() -> WriteDiaryViewController
    func writeMoodVC() -> WriteMoodViewController
    func writeImageVC() -> WriteImageViewController
    func emotionVC() -> EmotionViewController
//    func tabBarVC() -> TapBarViewController
//    func companyListVC() -> CompanyListViewController
}
