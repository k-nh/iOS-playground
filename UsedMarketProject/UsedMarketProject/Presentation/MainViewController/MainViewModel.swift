//
//  MainViewModel.swift
//  UsedMarketProject
//
//  Created by 김나희 on 2021/12/27.
//

import RxSwift
import RxCocoa
import UIKit

struct MainViewModel {
    let titleTextFieldCellViewModel = TitleTextFieldCellViewModel()
    let priceTextFieldCellViewModel = PriceTextFieldCellViewModel()
    let detailWriteFormCellViewModel = DetailWriteFormCellViewModel()
    
    // MARK: viewmodel -> view
    let cellData: Driver<[String]>
    let presentAlert: Signal<Alert>
    // category detail로 push
    let push: Driver<CategoryViewModel>
    
    // MARK: view -> viewmodel
    let itemSelected = PublishRelay<Int>()
    let submitButtonTapped = PublishRelay<Void>()

    init(model: MainModel = MainModel()) {
        // cell data
        let title = Observable.just("글 제목") // placeholder
        let categoryViewModel = CategoryViewModel()
        let category = categoryViewModel.selectedCategory
            .map { $0.name } // 선택한 카테고리 name
            .startWith("카테고리 선택") // 처음 placeholder
        
        let price = Observable.just("₩ 가격 (선택사항)")
        let detail = Observable.just("내용을 입력하세요")
        
        self.cellData = Observable
            .combineLatest(
                title,
                category,
                price,
                detail
            ) { [$0, $1, $2, $3] } // array로 묶어서
            .asDriver(onErrorJustReturn: []) // 에러나면 빈 array로
        
        // 제출버튼 눌렀을때 alert -> 텍스트 다 입력했는지 확인
        let titleMessage = titleTextFieldCellViewModel.titleText
            .map { $0?.isEmpty ?? true }
            .startWith(true)
        // true이면 (비어져있으면), 아니면 빈값
            .map { $0 ? ["- 글 제목을 입력해주세요."] : [] }
        
        let categoryMessage = categoryViewModel.selectedCategory
            .map { _ in false } // false로 시작
            .startWith(true) // 처음에 아무카테고리도 선택 안됨
            .map { $0 ? ["- 카테고리를 선택해주세요."] : [] }
        
        // price는 선택사항이기 때문에 필요 x
        
        let detailMessage = detailWriteFormCellViewModel.contentValue
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 내용을 입력해주세요."] : [] }
        
        let errorMessage = Observable
            .combineLatest(
                titleMessage,
                categoryMessage,
                detailMessage
            ) { $0+$1+$2 }
            
        // submitButtonTapped 되었을때 -> errormessage로 만들어놓은거 출력 (에러 없다면 빈 값)
        self.presentAlert = submitButtonTapped
            .withLatestFrom(errorMessage)
            .map (model.setAlert)
            .asSignal(onErrorSignalWith: .empty())
        
        // 카테고리 눌렀을때 push
        self.push = itemSelected
            .compactMap { row -> CategoryViewModel? in
                // 카테고리 셀(index row = 1) 이 맞다면
                guard case 1 = row else {
                    return nil
                }
                return categoryViewModel
            }
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
