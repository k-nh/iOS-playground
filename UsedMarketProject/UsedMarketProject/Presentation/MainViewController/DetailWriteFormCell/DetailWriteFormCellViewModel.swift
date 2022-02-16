//
//  DetailWriteFormCellViewModel.swift
//  UsedMarketProject
//
//  Created by 김나희 on 2022/02/15.
//

import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
    // view에서 viewmodel로 내용을 전달하는 것
    let contentValue = PublishRelay<String?>()
}
