import UIKit
import SnapKit
import Then
import Core
import MintKit

public class FindPassswordViewController: BaseFindVC {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "비밀번호 찾기"
        updateWith(self)
        mainButton.setTitle("비밀번호 찾기", for: .normal)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
   }
}
