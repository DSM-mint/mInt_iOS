import Foundation
import Presentation

public class ModuleFactory {
    public static let shared = ModuleFactory()
    private init() { }
}

extension ModuleFactory: ModuleFactoryInterface {
    
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
