import Foundation
import Presentation

public class ModuleFactory {
    public static let shared = ModuleFactory()
    private init() { }
}

extension ModuleFactory: ModuleFactoryInterface {
    
    public func loginVC() -> Presentation.LoginViewController {
        let loginVC = LoginViewController()

        return loginVC
    }
    
    public func mainVC() -> Presentation.MainViewController {
        let mainVC = MainViewController()
        
        return mainVC
    }
    
}
