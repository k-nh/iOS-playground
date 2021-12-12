//
//  ProfileCollectionViewCell.swift
//  InstagramClone
//
//  Created by 김나희 on 2021/12/09.
//

import UIKit
import SnapKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    func setup(with image: UIImage){
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageView.backgroundColor = .tertiaryLabel
    }
}
