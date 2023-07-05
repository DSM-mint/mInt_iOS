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

    private var buttonSelectionCounts = [[Int]].init(repeating: [0, 0, 0, 0], count: 20)


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
            surveyView.onButtonTapped = { [weak self] index, isSelectedButton1, isSelectedButton2, isSelectedButton3, isSelectedButton4 in
                self?.updateButtonSelectionCounts(index: index, isSelectedButton1: isSelectedButton1, isSelectedButton2: isSelectedButton2, isSelectedButton3: isSelectedButton3, isSelectedButton4: isSelectedButton4)
            }
        }

        surveryButton.snp.makeConstraints {
            $0.top.equalTo(previousView!.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(54)
        }

        surveryButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                let buttonToQuestions = owner.mostSelectedButtons()
                
                var statements: [Int: String] = [
                    -1: "Button 1",
                    0: "Button 2",
                    1: "Button 3",
                    2: "Button 4"
                ]
                
                var maxButtonIndex = Int.min
                var maxQuestionCount = Int.min
                
                for (buttonIndex, questionIndices) in buttonToQuestions {
                    guard let statementTemplate = statements[buttonIndex] else { continue }
                    
                    let questionCount = questionIndices.count
                    if questionCount > maxQuestionCount {
                        maxButtonIndex = buttonIndex
                        maxQuestionCount = questionCount
                    }
                    
                    if !questionIndices.isEmpty {
                        if statementTemplate == "Button 1" {
                            print("-----------------")
                            print("1")
                            self.navigationController?.pushViewController(BadResultViewController(), animated: true)
                            print("-----------------")
                        } else if statementTemplate == "Button 2" {
                            print("-----------------")
                            print("2")
                            self.navigationController?.pushViewController(SosoResultViewController(), animated: true)
                            print("-----------------")
                        } else if statementTemplate == "Button 3" {
                            print("-----------------")
                            print("3")
                            self.navigationController?.pushViewController(GoodResultViewController(), animated: true)
                            print("-----------------")
                        } else if statementTemplate == "Button 4" {
                            print("-----------------")
                            print("4")
                            self.navigationController?.pushViewController(BeastResultViewController(), animated: true)
                            print("-----------------")
                        }
                    }
                }
            }).disposed(by: disposeBag)
    }

    private func updateButtonSelectionCounts(index: Int, isSelectedButton1: Bool, isSelectedButton2: Bool, isSelectedButton3: Bool, isSelectedButton4: Bool) {
          buttonSelectionCounts[index] = [
              isSelectedButton1 ? buttonSelectionCounts[index][0] + 1 : buttonSelectionCounts[index][0],
              isSelectedButton2 ? buttonSelectionCounts[index][1] + 1 : buttonSelectionCounts[index][1],
              isSelectedButton3 ? buttonSelectionCounts[index][2] + 1 : buttonSelectionCounts[index][2],
              isSelectedButton4 ? buttonSelectionCounts[index][3] + 1 : buttonSelectionCounts[index][3]
          ]
      }
    
    private func mostSelectedButtons() -> [Int: [Int]] {
        var buttonToQuestions = [Int: [Int]]()
        
        for (questionIndex, counts) in buttonSelectionCounts.enumerated() {
            let mostSelectedButton = (counts.enumerated().max(by: { $0.element < $1.element })?.offset ?? 0) - 1
            if buttonToQuestions[mostSelectedButton] != nil {
                buttonToQuestions[mostSelectedButton]?.append(questionIndex)
            } else {
                buttonToQuestions[mostSelectedButton] = [questionIndex]
            }
        }
        
        return buttonToQuestions
    }
}
