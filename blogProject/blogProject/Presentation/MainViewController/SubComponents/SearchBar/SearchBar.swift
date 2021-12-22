//
//  SearchBar.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/18.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    let searchButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchBarViewModel) {
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBag)
        
        // 서치바의 키보드 서치 버튼 탭 , 검색 버튼 탭 -> 두가지 옵저버블
        // 위의 두가지 옵저버블이 이벤트를 발생할때마다 해당 이벤트가 tappedSearchButton로 바인딩
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        // end editing
        viewModel.searchButtonTapped
            .asSignal()
            .emit(to: self.rx.DidEndEditing)
            .disposed(by: disposeBag)
        
    }
    
}

private extension SearchBar {
    
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
