import UIKit
import SnapKit
import Then
import Core
import MintKit

public class FindIdViewController: BaseFindVC {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "아이디 찾기"
        updateWith(self)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
   }
}
