//
//  Alert.swift
//  LocalNotification
//
//  Created by 김나희 on 2021/10/04.
//

import Foundation

struct Alert:Codable {
    var id: String = UUID().uuidString
    var date: Date
    var isOn: Bool
    
    var time: String{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridiem: String{
        let meridiemFormatter = DateFormatter()
        // 오전,오후를 설명
        meridiemFormatter.dateFormat = "a"
        // 한국으로 locale 설정
        meridiemFormatter.locale = Locale(identifier: "ko")
        return meridiemFormatter.string(from: date)
    }
}
