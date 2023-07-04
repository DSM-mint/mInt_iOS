import UIKit
import SnapKit
import Then
import Core
import RxSwift
import RxCocoa

open class MintButton: UIButton {
    
    public convenience init(buttonTitle: String, titleColor: UIColor) {
        self.init(frame: .zero)
        self.setTitleColor(titleColor, for: .normal)
        setTitle(buttonTitle, for: .normal)
        self.layer.cornerRadius = 8.0
        self.backgroundColor = MintKitAsset.Colors.mainColor.color
        configureUI()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    open func configureUI() {
        titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        setTitleColor(.white, for: .normal)
    }
}
