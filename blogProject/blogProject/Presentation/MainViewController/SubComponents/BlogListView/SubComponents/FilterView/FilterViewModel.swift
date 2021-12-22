//
//  FilterViewModel.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/20.
//

import RxCocoa
import RxSwift

struct FilterViewModel {
    // filterview 외부에서 관찰
    let sortButtonTapped = PublishRelay<Void>()
}
