import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import MintKit

public class BeastResultViewController: BaseResultVC {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        resultLabel.text = "항상 이 생활과 패턴을 이어가세요!"
        resultLabel.textColor = .white
        consultingButton.setTitle("좋은 하루 일기 쓰기", for: .normal)
        feedbackLabel.text = "지금 굉장히 잘하고 있어요!"
        
        consultingButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.tabBarController?.selectedIndex = 1
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
