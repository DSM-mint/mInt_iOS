import UIKit
import SnapKit
import Then
import Core
import RxCocoa
import RxSwift
import MintKit

@available(iOS 16.0, *)
public class FindIdViewController: BaseFindVC {
    var disposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "아이디 찾기"
        updateWith(self)
        
        mainButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                self.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(FindIdResultViewController(), animated: true)
            }).disposed(by: disposeBag)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
   }
}
