import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import MintKit

public class ResultViewController: UIViewController {
    
    var disposeBag = DisposeBag()

    private var resultLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        let string = "현재 우울증이 심한 수준입니다"
        let attributedString = NSMutableAttributedString(string: string)
        
        if let otherTextRange = string.range(of: "현재 우울증이") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }
        
        if let nameRange = string.range(of: " 심한 수준") {
            let nsRange = NSRange(nameRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: nsRange)
        }
        
        if let otherTextRange = string.range(of: "입니다") {
            let nsRange = NSRange(otherTextRange, in: string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }

        $0.attributedText = attributedString
    }
    
    private var feedbackLabel = UILabel().then {
        $0.text = "가까운 병원이나 정신건강 전문가와 상담을 추천드립니다."
        $0.font = .systemFont(ofSize: 14.0, weight: .bold)
        $0.textColor = MintKitAsset.Colors.mainColor.color
    }
    
    private var consultingButton = MintButton(buttonTitle: "병원 또는 정신 건강 전문가와 상담하기", titleColor: .white, backgroud: MintKitAsset.Colors.mainColor.color)
    
    private var backButton = MintButton(buttonTitle: "나가기", titleColor: MintKitAsset.Colors.mainColor.color, backgroud: .white)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        
        layout()
        
        consultingButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.navigationController?.pushViewController(ConsultingWebViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    
    func layout() {
        [
            resultLabel,
            feedbackLabel,
            consultingButton,
            backButton
        ].forEach { view.addSubview($0) }
        
        resultLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
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
