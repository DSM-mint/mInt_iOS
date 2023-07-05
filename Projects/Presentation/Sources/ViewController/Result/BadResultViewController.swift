import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import MintKit

public class BadResultViewController: BaseResultVC {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        resultLabel.text = "자신의 솔직한 감정을 얘기해보고 싶진 않나요?"
        resultLabel.textColor = .white
        consultingButton.setTitle("전문가에게 감정 이야기하기", for: .normal)
        feedbackLabel.text = "일기나 전문가에게 솔직한 감정을 얘기해 보세요."
        backButton.setTitle("일기 작성하기", for: .normal)
        
        consultingButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.navigationController?.pushViewController(ConsultingWebViewController(), animated: true)
            }).disposed(by: disposeBag)

        backButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.tabBarController?.selectedIndex = 1
            }).disposed(by: disposeBag)

    }
}
