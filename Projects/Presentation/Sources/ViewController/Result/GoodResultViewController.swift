import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import MintKit

public class GoodResultViewController: BaseResultVC {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        resultLabel.text = "좋은 사람과 좋은 시간을 보는 건 어떨까요?"
        resultLabel.textColor = .white
        consultingButton.setTitle("즐거운 시간을 보내는 방법", for: .normal)
        feedbackLabel.text = "항상 즐거운 시간을 보내보세요."
        
        consultingButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.tabBarController?.selectedIndex = 2
            }).disposed(by: disposeBag)

        backButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                for viewController in viewControllerStack {
                  if let bView = viewController as? SurveyViewController {
                    self.navigationController?.popToViewController(bView, animated: true)
                    }
                }
            }).disposed(by: disposeBag)
    }
}
