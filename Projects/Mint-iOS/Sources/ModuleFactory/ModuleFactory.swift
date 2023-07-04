import Foundation
import Presentation

public class ModuleFactory {
    public static let shared = ModuleFactory()
    private init() { }
}

extension ModuleFactory: ModuleFactoryInterface {
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
