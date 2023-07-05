//
//  ProgressBarView.swift
//  MintKit
//
//  Created by 박준하 on 2023/07/05.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import UIKit
import SnapKit

open class ProgressBarView: UIView {
  public var ratio: CGFloat = 0.0 {
    didSet {
//      self.isHidden = !self.ratio.isLess(than: 1.0) // 없어지는 코드
      
      self.progressBarView.snp.remakeConstraints {
        $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
        $0.width.equalToSuperview().multipliedBy(self.ratio)
      }
      
      UIView.animate(
        withDuration: 0.5,
        delay: 0,
        options: .curveEaseInOut,
        animations: self.layoutIfNeeded,
        completion: nil
      )
    }
  }
  
  private let progressBarView: UIView = {
    let view = UIView()
      view.backgroundColor = MintKitAsset.Colors.mainColor.color
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.isUserInteractionEnabled = false
      self.backgroundColor = MintKitAsset.Colors.gary500.color
    self.addSubview(self.progressBarView)
  }
    required public init?(coder: NSCoder) {
    fatalError()
  }
}
