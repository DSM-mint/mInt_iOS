import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import MintKit

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
    
    public var instaButton = MintButton(buttonTitle: "인스타 스토리 공유", titleColor: .white)
    
    
    func updateWith(_ controller: UIViewController) {
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        layout()
        instaButton.isHidden = true
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
            backButton,
            instaButton
        ].forEach { view.addSubview($0) }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(280)
            $0.centerX.equalToSuperview()
        }
        
        feedbackLabel.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(10.0)
            $0.centerX.equalToSuperview()
        }
        
        instaButton.snp.makeConstraints {
            $0.top.equalTo(feedbackLabel.snp.bottom).offset(50.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
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

