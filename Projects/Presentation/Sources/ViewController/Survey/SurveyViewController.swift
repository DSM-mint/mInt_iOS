import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import MintKit

public class SurveyViewController: UIViewController {
    
    var disposeBag = DisposeBag()

    private var surveyViews = [SurveyView]()
    private let scrollView = UIScrollView()
    private let surveryButton = MintButton(buttonTitle: "완료하기", titleColor: .white)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let problemTexts = [
            "아무렇지도 않던 일들이 괴롭고\n 귀찮게 느껴졌다.",
            "먹고 싶지 않고 식욕이 없다.",
            "어느 누가 도와준다 하더라도 나의 울적한 기분을\n 떨쳐 버릴 수 없을 것 같다.",
            "무슨 일을 하던 정신을 집중하기가 힘들었다.",
            "비교적 잘 지냈다.",
            "상당히 우울했다.",
            "모든 일들이 힘들게 느껴졌다.",
            "앞일이 암담하게 느껴졌다.",
            "지금까지의 내 인생은 실패작이라는 생각이 들었다.",
            "적어도 보통 사람들만큼의 능력은 있었다고 생각한다.",
            "잠을 설쳤다(잠을 잘 이루지 못했다).",
            "두려움을 느꼈다.",
            "평소에 비해 말수가 적었다.",
            "세상에 홀로 있는 듯 한 외로움을 느꼈다.",
            "큰 불만 없이 생활했다.",
            "사람들이 나에게 차갑게 대하는 것 같았다.",
            "갑자기 울음이 나왔다.",
            "마음이 슬펐다.",
            "사람들이 나를 싫어하는 것 같았다.",
            "도무지 뭘 해 나갈 엄두가 나지 않았다."
        ]
        
        view.addSubview(scrollView)
        view.addSubview(surveryButton)
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = MintKitAsset.Colors.bkc.color
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        var previousView: SurveyView?
        
        for i in 0 ..< problemTexts.count {
            let surveyView = SurveyView(problemText: problemTexts[i])
            surveyViews.append(surveyView)
            contentView.addSubview(surveyView)
            
            surveyView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(150)
                
                if let previousView = previousView {
                    make.top.equalTo(previousView.snp.bottom).offset(70)
                } else {
                    make.top.equalToSuperview()
                }
                
                if i == problemTexts.count - 1 {
                    make.bottom.equalTo(contentView).offset(-120)
                }
            }
            
            previousView = surveyView
        }
        
        surveryButton.snp.makeConstraints {
            $0.top.equalTo(previousView!.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(54)
        }
        
        surveryButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
               print("findIdButton")
                self.navigationController?.pushViewController(BadResultViewController(), animated: true)
            }).disposed(by: disposeBag)
    }
}
