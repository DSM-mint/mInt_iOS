import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core

open class AddPictureView: UIView {
    
    public let pictureButton: UIButton
    public let pictureImage = UIImageView().then {
        $0.backgroundColor = MintKitAsset.Colors.gary700.color
    }
    
    private let pictureTitleBackgroundView = UIView().then {
        $0.backgroundColor = MintKitAsset.Colors.mainColor.color
    }

    public init(titleText: String) {
        
        pictureButton = UIButton().then {
            $0.setTitle(titleText, for: .normal)
            $0.setTitleColor(UIColor.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 10.0, weight: .bold)
            $0.backgroundColor = .clear
        }
        
        super.init(frame: .zero)
        
        setupLayout()
        pictureImage.layer.cornerRadius = 10.0
        pictureTitleBackgroundView.layer.cornerRadius = 10.0
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout() {
        addSubview(pictureImage)
        addSubview(pictureTitleBackgroundView)
        addSubview(pictureButton)
        
        pictureImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pictureTitleBackgroundView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30.0)
        }
        
        pictureButton.snp.makeConstraints {
            $0.edges.equalTo(pictureTitleBackgroundView)
        }
    }
}
