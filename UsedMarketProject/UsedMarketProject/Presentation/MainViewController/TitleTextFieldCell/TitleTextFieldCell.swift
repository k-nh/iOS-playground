//
//  TitleTextFieldCell.swift
//  UsedMarketProject
//
//  Created by 김나희 on 2021/12/27.
//


import UIKit
import SnapKit
import RxCocoa
import RxSwift

class TitleTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    let titleInputField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TitleTextFieldCellViewModel) {
        // titleInputField가 입력되는 text를 주면 viewmodel에 titleText에 바인딩
        titleInputField.rx.text
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
    }
}

private extension TitleTextFieldCell {
    func attribute() {
        titleInputField.font = .systemFont(ofSize: 17.0)
    }
    
    func setupLayout() {
        contentView.addSubview(titleInputField)
        
        titleInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20.0)
        }
    }
}
