//
//  CategoryViewModel.swift
//  UsedMarketProject
//
//  Created by 김나희 on 2022/01/01.
//

import RxSwift
import RxCocoa

struct CategoryViewModel {
    let disposeBag = DisposeBag()
    
    // viewmodel가 view에 주는 정보
    let cellData: Driver<[Category]>
    let pop: Signal<Void>
    
    // view가 viewmodel에 주는 정보
    let itemSelected = PublishRelay<Int>()
    
    // viewmodel가 parents modelview에 보낼 정보
    let selectedCategory = PublishSubject<Category>()
    
    init() {
        let categories = [
            Category(id: 1, name: "디지털/가전"),
            Category(id: 2, name: "게임"),
            Category(id: 3, name: "스포츠/레저"),
            Category(id: 4, name: "유아/아동용품"),
            Category(id: 5, name: "뷰티/미용"),
            Category(id: 6, name: "가구")
        ]
        
        self.cellData = Driver.just(categories)
        
        //itemSelected 선택된게 selectedCategory로 바인딩 => 외부에서는 selectedCategory만 확인해서 최신의 카테고리 무엇인지 확인가능
        self.itemSelected
            .map { categories[$0] }
            .bind(to: selectedCategory)
            .disposed(by: disposeBag)
        
        // itemSelected이 선택됐을때 -> Pop 시그널을 받아서 main이 액션을 취함
        self.pop = itemSelected
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
    }
    
}
