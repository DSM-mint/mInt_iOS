import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core

open class MintCertificationTwoTextField: UIView {
    
    public let textField1: UITextField
    public let button1: UIButton
    
    public init(placeholder1: String, buttonText: String, buttonTextColor: UIColor) {
        
        textField1 = UITextField().then {
            $0.font = .systemFont(ofSize: 15.0, weight: .medium)
            $0.textColor = .white
            $0.attributedPlaceholder = NSAttributedString(string: placeholder1, attributes: [NSAttributedString.Key.foregroundColor: MintKitAsset.Colors.gary500.color])
            $0.keyboardType = .emailAddress
            $0.clearButtonMode = .whileEditing
            $0.borderStyle = .roundedRect
            $0.backgroundColor = MintKitAsset.Colors.gary700.color
            $0.layer.cornerRadius = 4.0
        }
        
        textField1.frame = CGRect(x: 0, y: 0, width: 220.0, height: 54.0)
        
        button1 = UIButton().then {
            $0.titleLabel?.text = buttonText
            $0.backgroundColor = MintKitAsset.Colors.mainColor.color
            $0.frame = CGRect(x: 0, y: 0, width: 72.0, height: 54.0)
            $0.layer.cornerRadius = 8.0
            $0.setTitleColor(buttonTextColor, for: .normal)
            
        }

        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout() {
        addSubview(textField1)
        addSubview(button1)
        
        textField1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.0)
            $0.leading.equalToSuperview()
            $0.height.equalTo(54.0)
            $0.width.equalTo(220.0)
        }
        
        button1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.0)
            $0.leading.equalTo(textField1.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(54.0)
            $0.width.equalTo(72.0)
        }
    }
}
