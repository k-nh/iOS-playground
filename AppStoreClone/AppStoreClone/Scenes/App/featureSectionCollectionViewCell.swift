//
//  featureSectionCollectionViewCell.swift
//  AppStoreClone
//
//  Created by 김나희 on 2021/11/30.
//

import UIKit
import SnapKit

final class featureSectionCollectionViewCell: UICollectionViewCell{
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .systemBlue
        
        return label
    }()
    private lazy var appTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 7
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.separator.cgColor
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        
        return image
    }()

    func setup(feature: Feature){
        setupLayout()
        
        typeLabel.text = feature.type
        appTitleLabel.text = feature.appName
        descriptionLabel.text = feature.description
        if let imageURL = URL(string: feature.imageURL){
            imageView.kf.setImage(with: imageURL)
        }
    }
}

private extension featureSectionCollectionViewCell {
    func setupLayout(){
        [imageView, typeLabel, appTitleLabel, descriptionLabel]
            .forEach { addSubview($0) }
        
        typeLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
        
        appTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(typeLabel.snp.bottom)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(appTitleLabel.snp.bottom).offset(4)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(8)

        }
    }
}
