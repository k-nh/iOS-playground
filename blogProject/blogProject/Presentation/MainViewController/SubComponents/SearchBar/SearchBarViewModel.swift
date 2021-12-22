//
//  SearchBarViewModel.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/20.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
    let queryText = PublishRelay<String?>()
    
    // search button 버튼 탭 이벤트
    let searchButtonTapped = PublishRelay<Void>()
    
    // searh bar 외부로 내보낼 이벤트 - 텍스트
    var shoudLoadResult: Observable<String>
    
    init(){
        // 검색 버튼을 눌렀을때 최신의 텍스트가 빈값이나 중복값 없이 전달됨
        self.shoudLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? ""}
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }

}
