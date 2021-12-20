//
//  SearchBar.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
    // search button 버튼 탭 이벤트
    let searchButtonTapped = PublishRelay<Void>()
    
    // searh bar 외부로 내보낼 이벤트 - 텍스트
    var shoudLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SearchBar {
    func bind() {
        // 서치바의 키보드 서치 버튼 탭 , 검색 버튼 탭 -> 두가지 옵저버블
        // 위의 두가지 옵저버블이 이벤트를 발생할때마다 해당 이벤트가 tappedSearchButton로 바인딩
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: searchButtonTapped)
            .disposed(by: disposeBag)
        
        // end editing
        searchButtonTapped
            .asSignal()
            .emit(to: self.rx.DidEndEditing)
            .disposed(by: disposeBag)
        
        // 검색 버튼을 눌렀을때 최신의 텍스트가 빈값이나 중복값 없이 전달됨
        self.shoudLoadResult = searchButtonTapped
            .withLatestFrom(self.rx.text) { $1 ?? ""}
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
    
    func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    func setupLayout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        
    }
}

// end editting
extension Reactive where Base: SearchBar {
    var DidEndEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
