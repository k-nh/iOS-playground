//
//  ContentCollectionViewCell.swift
//  MovieRecommendProject
//
//  Created by 김나희 on 2021/10/06.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell{
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        
        //autolayout - snapkit 이용
        imageView.snp.makeConstraints{
            // 모든 엣지에 다 붙게
            $0.edges.equalToSuperview()
        }
    }
}
