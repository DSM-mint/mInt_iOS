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

public class SosoResultViewController: BaseResultVC {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        resultLabel.text = "가벼운 산책이나 나들이를 해보시는건 어떄요?"
        resultLabel.textColor = .white
        consultingButton.setTitle("가까운 공원 보기", for: .normal)
        feedbackLabel.text = "가까운 공원을 추천 해드릴게요"
    }
}

public class GoodResultViewController: BaseResultVC {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        resultLabel.text = "좋은 사람과 좋은 시간을 보는 건 어떨까요?"
        resultLabel.textColor = .white
        consultingButton.setTitle("즐거운 시간을 보내는 방법", for: .normal)
        feedbackLabel.text = "항상 즐거운 시간을 보내보세요."
    }
}

public class BeastResultViewController: BaseResultVC {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        resultLabel.text = "항상 이 생활과 패턴을 이어가세요!"
        resultLabel.textColor = .white
        consultingButton.setTitle("좋은 하루 일기 쓰기", for: .normal)
        feedbackLabel.text = "지금 굉장히 잘하고 있어요!"
    }
}


public class BaseResultVC: UIViewController {
    var disposeBag = DisposeBag()

    public var resultLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.text = "현재 우울증이 심한 수준입니다"
    }
    
    public var feedbackLabel = UILabel().then {
        $0.text = "가까운 병원이나 정신건강 전문가와 상담을 추천드립니다."
        $0.font = .systemFont(ofSize: 14.0, weight: .bold)
        $0.textColor = MintKitAsset.Colors.mainColor.color
    }
    
    public var consultingButton = MintButton(buttonTitle: "병원 또는 정신 건강 전문가와 상담하기", titleColor: .white, backgroud: MintKitAsset.Colors.mainColor.color)
    
    public var backButton = MintButton(buttonTitle: "나가기", titleColor: MintKitAsset.Colors.mainColor.color, backgroud: .white)
    
    
    func updateWith(_ controller: UIViewController) {
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        layout()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        updateWith(self)
    }
    
    func layout() {
        [
            resultLabel,
            feedbackLabel,
            consultingButton,
            backButton
        ].forEach { view.addSubview($0) }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(280)
            $0.centerX.equalToSuperview()
        }
        
        feedbackLabel.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(10.0)
            $0.centerX.equalToSuperview()
        }
        
        consultingButton.snp.makeConstraints {
            $0.top.equalTo(feedbackLabel.snp.bottom).offset(226.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(consultingButton.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
        }
    }
}
