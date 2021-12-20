//
//  FilterView.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class FilterView: UITableViewHeaderFooterView {
    let disposeBag = DisposeBag()
    
    let sortButton = UIButton()
    let border = UIView()
    
    // filterview 외부에서 관찰
    let sortButtonTapped = PublishRelay<Void>()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        bind()
        attribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: private
private extension FilterView {
    func bind() {
        // sort button 탭 이벤트 방출 시 -> tappedSortButton 바인딩
        sortButton.rx.tap
            .bind(to: sortButtonTapped)
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        // sort 버튼 ui
        sortButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        border.backgroundColor = .lightGray
    }
    
    func setupLayout() {
        [sortButton, border]
            .forEach { addSubview($0) }
        
        sortButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12.0)
            $0.top.equalToSuperview()
            $0.width.height.equalTo(28.0)
        }
        
        border.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
    }
}
