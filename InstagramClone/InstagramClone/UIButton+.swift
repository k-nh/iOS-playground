//
//  UIButton+.swift
//  InstagramClone
//
//  Created by 김나희 on 2021/12/08.
//

import UIKit

// 버튼 사이즈 맞추기
extension UIButton{
    func setImage(systemName: String) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = .zero
        
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}
