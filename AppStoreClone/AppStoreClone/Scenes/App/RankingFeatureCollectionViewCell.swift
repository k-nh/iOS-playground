//
//  RankingFeatureCollectionViewCell.swift
//  AppStoreClone
//
//  Created by 김나희 on 2021/12/01.
//

import UIKit
import SnapKit

final class RankingFeatureCollectionViewCell: UICollectionViewCell {
    static var height: CGFloat { 70.0 }
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .tertiarySystemBackground
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.tertiaryLabel.cgColor
        image.layer.cornerRadius = 7.0
        
        return image
    }()
    private lazy var appTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    private lazy var inAppPurchaseInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 내 구입"
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 12.0
        
        return button
    }()

    func setup(rankingFeature: RankingFeature){
        setupLayout()
        
        appTitleLabel.text = rankingFeature.title
        descriptionLabel.text = rankingFeature.description
        inAppPurchaseInfoLabel.isHidden = !rankingFeature.isInPurchaseApp
    }
}

private extension RankingFeatureCollectionViewCell {
    func setupLayout(){
        [imageView, appTitleLabel, descriptionLabel, inAppPurchaseInfoLabel, downloadButton]
            .forEach { addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4.0)
            $0.width.equalTo(imageView.snp.height)
        }
        
        appTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8.0)
            $0.trailing.equalTo(downloadButton.snp.leading)
            $0.top.equalTo(imageView.snp.top).inset(8.0)
        }
        downloadButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24.0)
            $0.width.equalTo(50.0)
        }
        inAppPurchaseInfoLabel.snp.makeConstraints {
            $0.centerX.equalTo(downloadButton.snp.centerX)
            $0.top.equalTo(downloadButton.snp.bottom).offset(4.0)
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(appTitleLabel.snp.leading)
            $0.trailing.equalTo(appTitleLabel.snp.trailing)
            $0.top.equalTo(appTitleLabel.snp.bottom).offset(4.0)
        }
        
    }

}
