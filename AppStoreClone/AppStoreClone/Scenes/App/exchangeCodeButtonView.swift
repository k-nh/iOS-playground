//
//  exchangeCodeButtonView.swift
//  AppStoreClone
//
//  Created by 김나희 on 2021/12/01.
//

import UIKit
import SnapKit


final class exchangeCodeButtonView: UIView {
    private lazy var exchangeCodeButtonView: UIButton = {
        let button = UIButton()
        button.setTitle("코드 교환", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .tertiarySystemGroupedBackground
        button.layer.cornerRadius = 7.0
        
       return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(exchangeCodeButtonView)
        
        exchangeCodeButtonView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(32.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(40.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

