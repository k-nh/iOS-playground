//
//  StationDetailCell.swift
//  SubwayStation
//
//  Created by 김나희 on 2021/12/02.
//

import UIKit
import SnapKit


final class StationDetailCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        
        label.textColor = .label
       
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
       
        return label
    }()
    
    func setup(with realtimeArrival:StationArrivalDataResponseModel.RealTimeArrival){
        backgroundColor = .systemBackground
        
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        
        
        setupLayout()
        titleLabel.text = realtimeArrival.line
        secondLabel.text = realtimeArrival.remainTime
    }
    
    func setupLayout(){
        [titleLabel, secondLabel]
            .forEach {
                addSubview($0)
            }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16.0)
        }
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
}

