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
        instaButton.isHidden = false
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
        
        instaButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                let capturedImage = self.viewContentsToImage()
                print("View captured as image:", capturedImage)
                self.shareToInstagramStory(with: capturedImage, to: self)
                       
            }).disposed(by: disposeBag)

    }
    
    func viewContentsToImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { ctx in
            view.layer.render(in: ctx.cgContext)
        }
    }
    
    func shareToInstagramStory(with image: UIImage, to viewController: UIViewController) {
        guard let storyShareURL = URL(string: "instagram-stories://share?source_application=660435899280434") else {
            return
        }
        guard UIApplication.shared.canOpenURL(storyShareURL) else {
            return
        }

        guard let imageData = image.pngData() else {
            return
        }

        let pasteboardItems: [String: Any] = [
            "com.instagram.sharedSticker.stickerImage": imageData,
            "com.instagram.sharedSticker.backgroundTopColor": "#636e72",
            "com.instagram.sharedSticker.backgroundBottomColor": "#b2bec3"
        ]

        let pasteboardOptions = [
            UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)
        ]

        UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
        UIApplication.shared.open(storyShareURL, options: [:], completionHandler: nil)
    }
}
