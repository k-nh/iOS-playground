//
//  MainModel.swift
//  UsedMarketProject
//
//  Created by 김나희 on 2022/02/15.
//

import Foundation

struct MainModel {
    func setAlert(errorMessage: [String])  -> Alert {
        let title = errorMessage.isEmpty ? "성공" : "실패"
        let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n") // 메세지들 한줄씩
        
        return Alert(title, message)
    }
}
