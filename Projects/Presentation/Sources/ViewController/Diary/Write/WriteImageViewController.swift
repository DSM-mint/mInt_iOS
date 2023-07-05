//
//  WriteImageViewController.swift
//  Presentation
//
//  Created by 박준하 on 2023/07/05.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core
import MintKit

//3
@available(iOS 16.0, *)
public class WriteImageViewController: UIViewController {
    
    var disposeBag = DisposeBag()

    private var imageTitle = UILabel().then {
        $0.text = "오늘 기분을 사진으로 표현해보세요."
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    private let progressBarView = ProgressBarView()
    private let addPictureView = AddPictureView(titleText: "사진 추가하기")
    private let okButton = MintButton(buttonTitle: "완료하기", titleColor: .white)

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MintKitAsset.Colors.bkc.color
        
        layout()
        var timer = 0.0
        let finish = 3.0
        timer += 3
        self.progressBarView.ratio = timer / finish
        
        okButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                for viewController in viewControllerStack {
                  if let bView = viewController as? DiaryViewController {
                    self.navigationController?.popToViewController(bView, animated: true)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    func layout() {
        view.addSubview(imageTitle)
        view.addSubview(progressBarView)
        view.addSubview(addPictureView)
        view.addSubview(okButton)
        
        imageTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        progressBarView.snp.makeConstraints {
            $0.top.equalTo(imageTitle.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(4.0)
            $0.width.equalTo(370.0)
        }
        
        addPictureView.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(116.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(140.0)
        }
        
        okButton.snp.makeConstraints {
            $0.top.equalTo(addPictureView.snp.bottom).offset(300.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(54.0)
        }
    }
}
