//
//  TodayCollectionViewHeader.swift
//  AppStoreClone
//
//  Created by 김나희 on 2021/11/30.
//

import UIKit
import SnapKit

final class TodayCollectionViewHeader: UICollectionReusableView {
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        let curDate = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "MM월 dd일 eeee"
        label.text = formatter.string(from: curDate)
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .secondaryLabel
            
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투데이"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .black
            
        return label
    }()
    
    func setupViews(){
        [dateLabel, titleLabel]
            .forEach { addSubview($0) }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(16)
            //$0.trailing.equalToSuperview()
        }
    
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.leading.equalTo(dateLabel)
        }
    }
}
