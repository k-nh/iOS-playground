//
//  BlogListCell.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/18.
//

import UIKit
import SnapKit
import Kingfisher

class BlogListCell: UITableViewCell {
    let thumnailImageView = UIImageView()
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let datetimeLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
}

extension BlogListCell {
    func setupLayout(){
        thumnailImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        
        datetimeLabel.font = .systemFont(ofSize: 12, weight: .light)
        
        [thumnailImageView, nameLabel, titleLabel, datetimeLabel]
            .forEach { contentView.addSubview($0) }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8.0)
            $0.trailing.lessThanOrEqualTo(thumnailImageView.snp.leading).offset(8)
        }
        
        thumnailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.trailing.bottom.equalToSuperview().inset(8.0)
            $0.width.height.equalTo(80.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(thumnailImageView.snp.leading).offset(8)
        }
        
        
        datetimeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalTo(thumnailImageView)
        }
    }
    
    func setData(_ data: BlogListCellData){
        thumnailImageView.kf.setImage(with: data.thumbnailURL, placeholder: UIImage(systemName: "photo"))
        print("** ",data.thumbnailURL)
        nameLabel.text = data.name
        titleLabel.text = data.title
        
        var datetime: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let contentDate = data.datetime ?? Date()
            
            return dateFormatter.string(from: contentDate)
        }
        
        datetimeLabel.text = datetime
    }
}
