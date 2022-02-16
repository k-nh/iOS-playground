//
//  TitleTextFieldCellViewModel.swift
//  UsedMarketProject
//
//  Created by 김나희 on 2021/12/27.
//

import Foundation
import RxCocoa

// 입력되어있는 text값을(title)을 mainviewcontroller에 넘겨줌. 제출버튼이 눌렸을때 가장 최근에 값이 입력된 상태인지 확인
struct TitleTextFieldCellViewModel {
    let titleText = PublishRelay<String?>()
}

