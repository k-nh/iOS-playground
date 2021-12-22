//
//  MainViewModel.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/20.
//

import RxSwift
import RxCocoa
import Foundation

struct MainViewModel {
    let disposeBag = DisposeBag()
    
    let searchBarViewModel = SearchBarViewModel()
    let listViewModel = BlogListViewModel()
    
    let alertActionTapped = PublishRelay<MainViewController.AlertAction>()
    let shouldPresentAlert: Signal<MainViewController.Alert>
    
    init(model: MainModel = MainModel()){
        // searchbar에 입력된 커리 -> SearchBlogNetwork
        let blogResult = searchBarViewModel.shoudLoadResult
            .flatMapLatest(model.searchBlog)
            .share() // 여러군데에서 공유
        
        // 네트워크로 가져온 값 -> 성공값, 에러값
        let blogValue = blogResult
            .compactMap(model.getBlogValue)
        
        let blogError = blogResult
            .compactMap(model.getBlogError)
        
        // 네트워크로 가져온 값 celldata로 변환
        let cellData = blogValue
            .map(model.getBlogListCellData)
        
        // filter view를 선택했을때 나오는 alert sheet type
        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                case .title, .datetime:
                    return true
                default:
                    return false
                }
            }
            .startWith(.title)
        
        // cellData + sortedType (MainViewController) -> listView에 뿌려주기
        Observable
            .combineLatest(
                sortedType,
                cellData,
                resultSelector: model.sort
            )
            .bind(to: listViewModel.blogCellData)
            .disposed(by: disposeBag)
    
        // alert 구현
        let alertSheetForSorting = listViewModel.filterViewModel.sortButtonTapped
            .map { _ -> MainViewController.Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .map { message -> MainViewController.Alert in
                return (
                    title: "앗!",
                    message : "예상치 못한 오류가 발생했습니다. 잠시 후 다시 시도해주세요. \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }
        
        self.shouldPresentAlert = Observable
            .merge(
                alertSheetForSorting,
                alertForErrorMessage
            )
            .asSignal(onErrorSignalWith: .empty())
    }
}
