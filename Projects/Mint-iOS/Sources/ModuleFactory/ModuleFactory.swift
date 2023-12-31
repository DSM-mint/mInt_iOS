import Foundation
import Presentation

public class ModuleFactory {
    public static let shared = ModuleFactory()
    private init() { }
}

@available(iOS 16.0, *)
extension ModuleFactory: ModuleFactoryInterface {
    public func emotionVC() -> Presentation.EmotionViewController {
        let emotionVC = EmotionViewController()
        
        return emotionVC
    }
    
    
    public func writeImageVC() -> Presentation.WriteImageViewController {
        let writeImageVC = WriteImageViewController()
        
        return writeImageVC
    }
    
    public func writeMoodVC() -> Presentation.WriteMoodViewController {
        let writeMoodVC = WriteMoodViewController()
        
        return writeMoodVC
    }
    
    public func writeDiaryVC() -> Presentation.WriteDiaryViewController {
        let writeDiaryVC = WriteDiaryViewController()
        
        return writeDiaryVC
    }
    
    
    public func editProfileVC() -> Presentation.EditProfileViewController {
        let editProfileVC = EditProfileViewController()
        
        return editProfileVC
    }
    
//    public func detailArtVC() -> Presentation.DetailArtViewController {
//        let detailArtVC = DetailArtViewController()
//
//        return detailArtVC
//    }
    
    public func artVC() -> Presentation.ArtViewController {
        let artVC = ArtViewController()
        
        return artVC
    }
    
    public func diaryVC() -> Presentation.DiaryViewController {
        let diaryVC = DiaryViewController()
        
        return diaryVC
    }
    
    public func resultVC() -> Presentation.BadResultViewController {
        let resultVC = BadResultViewController()
        
        return resultVC
    }
    
    public func surveyVC() -> Presentation.SurveyViewController {
        let surveryVC = SurveyViewController()
        
        return surveryVC
    }
    
    public func tapbarVC() -> Presentation.TapbarViewController {
        let tapbarVC = TapbarViewController()
        
        return tapbarVC
    }
    
    public func signUpVC() -> Presentation.SignUpViewController {
        let signupVC = SignUpViewController()
        
        return signupVC
    }
    
    public func findPasswordVC() -> Presentation.FindPassswordViewController {
        let findPassswordVC = FindPassswordViewController()
        
        return findPassswordVC
    }
    
    
    public func findIdVC() -> Presentation.FindIdViewController {
        let findIdVC = FindIdViewController()
        
        return findIdVC
    }
    
    
    public func loginVC() -> Presentation.LoginViewController {
        let loginVC = LoginViewController()

        return loginVC
    }

    public func mainVC() -> Presentation.MainViewController {
        let mainVC = MainViewController()
        
        return mainVC
    }
    
    
    
}
