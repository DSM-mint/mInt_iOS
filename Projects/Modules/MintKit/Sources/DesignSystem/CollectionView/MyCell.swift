import UIKit

open class MyCell: UICollectionViewCell {

    static var id: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }

    var myModel: MyModel? {
        didSet { bind() }
    }

    public var containerView: UIImageView = {
        let view = UIImageView()

        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    init(frame: CGRect, containerViewImage: UIImage, titleLabelText: String, subLabelText: String) {
        super.init(frame: frame)
        
        setupView()
        containerView.image = containerViewImage
        titleLabel.text = titleLabelText
        subLabel.text = subLabelText
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError()
    }

    private func setupView() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
        titleLabel.text = myModel?.commentString
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(containerView.snp.centerX)
            $0.top.equalToSuperview().offset(162.0)
        }
        
        containerView.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.centerX.equalTo(containerView.snp.centerX)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
    }

    private func bind() {
        containerView.layer.cornerRadius = 16.0
//        containerView.backgroundColor = myModel?.color
        containerView.image = MintKitAsset.Assets.testImage1.image
        subLabel.text = "2023.6.12"
        titleLabel.text = myModel?.commentString
    }
}
