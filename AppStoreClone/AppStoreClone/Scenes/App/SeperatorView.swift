//
//  SeperatorView.swift
//  AppStoreClone
//
//  Created by 김나희 on 2021/11/30.
//

import UIKit
import SnapKit

final class SeperatorView: UIView {
    private lazy var seperator: UIView = {
        let seperator = UIView()
        seperator.backgroundColor = .separator
        
        return seperator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(seperator)
        seperator.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.top.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
