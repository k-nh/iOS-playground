//
//  BlogListViewModel.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/20.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
    // 헤더
    let filterViewModel = FilterViewModel()
    
    // MainViewController 네트워크 작업 -> BlogTableView
    let blogCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init() {
        // driver로 바꿔주고 에러나면 빈 array
        self.cellData = blogCellData
            .asDriver(onErrorJustReturn: [])
    }
}
