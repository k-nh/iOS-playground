//
//  PriceTextFieldCellViewModel.swift
//  UsedMarketProject
//
//  Created by 김나희 on 2022/02/14.
//

import RxSwift
import RxCocoa

struct PriceTextFieldCellViewModel {
    // viewmodel -> view
    let showFreeShareButton: Signal<Bool>
    let resetPrice: Signal<Void>
    
    // view->viewmodel
    let priceValue = PublishRelay<String?>()
    let freeShareButtonTapped = PublishRelay<Void>()
    
    
    init() {
        self.showFreeShareButton = Observable
            .merge(
                // showFreeShareButton -> 가격이 0이거나 무료나눔버튼눌렸을때
                priceValue.map { $0 ?? "" == "0" },
                freeShareButtonTapped.map { _ in false } // 숨겨줘
            )
            .asSignal(onErrorJustReturn: false) // 에러나도 숨겨라
        
        self.resetPrice = freeShareButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }

    
}
