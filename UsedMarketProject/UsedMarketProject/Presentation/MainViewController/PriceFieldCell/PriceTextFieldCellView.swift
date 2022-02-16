//
//  PriceTextFieldCellView.swift
//  UsedMarketProject
//
//  Created by 김나희 on 2022/02/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PriceTextFieldCellView: UITableViewCell {
    let disposeBag = DisposeBag()
    let priceInputField = UITextField()
    let freeShareButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: PriceTextFieldCellViewModel) {
        // viewmodel에서 받아오기
        viewModel.showFreeShareButton // 보여줘라 (true)
            .map { !$0 } // 뒤집기 -> false
            .emit(to: freeShareButton.rx.isHidden) // -> hidden
            .disposed(by: disposeBag)
        
        viewModel.resetPrice
            .map { _ in "" }
            .emit(to: priceInputField.rx.text) // 빈값으로 전환
            .disposed(by: disposeBag)
        
        // viewmodel로 넘기기
        priceInputField.rx.text
            .bind(to: viewModel.priceValue)
            .disposed(by: disposeBag)
        
        freeShareButton.rx.tap
            .bind(to: viewModel.freeShareButtonTapped)
            .disposed(by: disposeBag)
    }
    
}


private extension PriceTextFieldCellView {
    func attribute() {
        freeShareButton.setTitle("무료나눔", for: .normal)
        freeShareButton.setTitleColor(.orange, for: .normal)
        freeShareButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        freeShareButton.titleLabel?.font = .systemFont(ofSize: 18)
        freeShareButton.tintColor = .orange
        freeShareButton.backgroundColor = .white
        freeShareButton.layer.borderColor = UIColor.orange.cgColor
        freeShareButton.layer.cornerRadius = 10
        freeShareButton.layer.borderWidth = 1.0
        freeShareButton.clipsToBounds = true
        freeShareButton.isHidden = true
        freeShareButton.semanticContentAttribute = .forceRightToLeft
        
        priceInputField.keyboardType = .numberPad
        priceInputField.font = .systemFont(ofSize: 17)
        
    }
    
    func layout() {
        [priceInputField, freeShareButton].forEach {
            contentView.addSubview($0)
        }
        
        priceInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        freeShareButton.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(15)
            $0.width.equalTo(100)
        }
    }
}
