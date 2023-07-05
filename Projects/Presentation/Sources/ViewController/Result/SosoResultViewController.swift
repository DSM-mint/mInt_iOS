import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import MintKit

public class SosoResultViewController: BaseResultVC {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        resultLabel.text = "가벼운 산책이나 나들이를 해보시는건 어떄요?"
        resultLabel.textColor = .white
        consultingButton.setTitle("가까운 공원 보기", for: .normal)
        feedbackLabel.text = "가까운 공원을 추천 해드릴게요"
        
        consultingButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.navigationController?.pushViewController(ParkWebViewController(), animated: true)
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
