import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core

open class MintFourTextField: UIView {
    
    public let textField1: UITextField
    public let textField2: UITextField
    public let textField3: UITextField
    public let textField4: UITextField
    
    public init(placeholder1: String, placeholder2: String, placeholder3: String, placeholder4: String) {
        
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
        
        textField2 = UITextField().then {
            $0.font = .systemFont(ofSize: 15.0, weight: .medium)
            $0.textColor = .white
            $0.attributedPlaceholder = NSAttributedString(string: placeholder2, attributes: [NSAttributedString.Key.foregroundColor: MintKitAsset.Colors.gary500.color])
            $0.isSecureTextEntry = true
            $0.clearButtonMode = .whileEditing
            $0.borderStyle = .roundedRect
            $0.backgroundColor = MintKitAsset.Colors.gary700.color
            $0.layer.cornerRadius = 4.0
        }
        
        textField3 = UITextField().then {
            $0.font = .systemFont(ofSize: 15.0, weight: .medium)
            $0.textColor = .white
            $0.attributedPlaceholder = NSAttributedString(string: placeholder3, attributes: [NSAttributedString.Key.foregroundColor: MintKitAsset.Colors.gary500.color])
            $0.keyboardType = .emailAddress
            $0.clearButtonMode = .whileEditing
            $0.borderStyle = .roundedRect
            $0.backgroundColor = MintKitAsset.Colors.gary700.color
            $0.layer.cornerRadius = 4.0
        }
        
        textField4 = UITextField().then {
            $0.font = .systemFont(ofSize: 15.0, weight: .medium)
            $0.textColor = .white
            $0.attributedPlaceholder = NSAttributedString(string: placeholder4, attributes: [NSAttributedString.Key.foregroundColor: MintKitAsset.Colors.gary500.color])
            $0.isSecureTextEntry = true
            $0.clearButtonMode = .whileEditing
            $0.borderStyle = .roundedRect
            $0.backgroundColor = MintKitAsset.Colors.gary700.color
            $0.layer.cornerRadius = 4.0
        }
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout() {
        addSubview(textField1)
        addSubview(textField2)
        addSubview(textField3)
        addSubview(textField4)
        
        textField1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54.0)
        }

        textField2.snp.makeConstraints {
            $0.top.equalTo(textField1.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54.0)
        }
        
        textField3.snp.makeConstraints {
            $0.top.equalTo(textField2.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54.0)
        }

        textField4.snp.makeConstraints {
            $0.top.equalTo(textField3.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54.0)
        }
    }
}
