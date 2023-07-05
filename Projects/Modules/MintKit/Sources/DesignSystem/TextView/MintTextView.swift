//
//  MintTextView.swift
//  MintKit
//
//  Created by 박준하 on 2023/07/05.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Core

public class MintTextView: UIView {
    let titleLabel: UILabel
    let textView: UITextView
    let countLabel: UILabel

    let placeholder = "내용을 입력해주세요"
    var maxCharacterCount: Int
    var textViewHeight: CGFloat

    public init(maxCharacterCount: Int = 300, textViewHeight: CGFloat = 190) {
        self.maxCharacterCount = maxCharacterCount
        self.textViewHeight = textViewHeight

        titleLabel = UILabel().then {
            $0.text = "제목"
            $0.font = .systemFont(ofSize: 20)
            $0.textColor = .black
            $0.textAlignment = .right
        }

        textView = UITextView().then {
            $0.font = .systemFont(ofSize: 14)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = MintKitAsset.Colors.gary700.color
            $0.tintColor = .black
            $0.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 18, right: 0)
        }

        countLabel = UILabel().then {
            $0.text = "0/\(maxCharacterCount)"
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = MintKitAsset.Colors.gary700.color
            $0.textAlignment = .right
        }

        super.init(frame: .zero)

        setupLayout()
        setupTextView()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(textView)
        addSubview(countLabel)

        textView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            $0.height.equalTo(textViewHeight)
            $0.leading.trailing.equalToSuperview().inset(30.0)
        }

        countLabel.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(28)
        }
    }

    private func setupTextView() {
        textView.delegate = self
        textView.text = placeholder
        textView.textColor = .gray
    }
}

extension MintTextView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderWidth = 1
        textView.layer.borderColor = MintKitAsset.Colors.mainColor.color.cgColor

        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.textColor = .gray
            textView.text = placeholder
        } else if textView.text == placeholder {
            textView.textColor = .white
            textView.text = nil
        }
    }

    public func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > maxCharacterCount {
            textView.deleteBackward()
        }

        countLabel.text = "\(textView.text.count)/\(maxCharacterCount)"

        let attributedString = NSMutableAttributedString(string: "\(textView.text.count)/\(maxCharacterCount)")
        attributedString.addAttribute(.foregroundColor, value: MintKitAsset.Colors.mainColor.color, range: ("\(textView.text.count)/\(maxCharacterCount)" as NSString).range(of:"\(textView.text.count)"))
        countLabel.attributedText = attributedString
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderWidth = 0

        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            textView.textColor = MintKitAsset.Colors.gary700.color
            textView.text = placeholder
            countLabel.textColor =  MintKitAsset.Colors.gary700.color
            countLabel.text = "0/\(maxCharacterCount)"
        }
    }
}
