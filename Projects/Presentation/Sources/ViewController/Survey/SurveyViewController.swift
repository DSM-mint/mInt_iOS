import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import MintKit

public class SurveyViewController: UIViewController {
    
    private lazy var surveyView1 = SurveyView(problemText: "아무렇지도 않던 일들이 괴롭고\n귀찮게 느껴져요 ")
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(surveyView1)
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        
        title = "정신 자가진단"
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        surveyView1.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
