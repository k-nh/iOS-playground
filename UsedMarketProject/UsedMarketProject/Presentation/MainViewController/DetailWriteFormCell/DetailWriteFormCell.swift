//
//  DetailWriteFormCell.swift
//  UsedMarketProject
//
//  Created by 김나희 on 2022/02/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DetailWriteFormCell: UITableViewCell {
    let disposeBag = DisposeBag()
    let contentInputView = UITextView() // textfield 보다 멀티라인은 textview가 좋음
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DetailWriteFormCellViewModel) {
        contentInputView.rx.text
            .bind(to: viewModel.contentValue)
            .disposed(by: disposeBag)
    }
}


private extension DetailWriteFormCell {
    func attribute() {
        
        contentInputView.font = .systemFont(ofSize: 17)
        
    }
    
    func layout() {
        contentView.addSubview(contentInputView)

        contentInputView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(300)
        }
    }
}
