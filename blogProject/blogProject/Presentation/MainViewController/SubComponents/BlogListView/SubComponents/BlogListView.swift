//
//  BlogTableView.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/18.
//

import UIKit
import RxSwift
import RxCocoa

class BlogListView: UITableView {
    let disposeBag = DisposeBag()
    
    let headerView = FilterView(
        frame: CGRect(
            origin: .zero,
            size: CGSize(width: UIScreen.main.bounds.width, height: 50.0)
        )
    )
    

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: BlogListViewModel) {
        headerView.bind(viewModel.filterViewModel)
        
        // cellforRowAt delegate -> rx로 표현
        viewModel.cellData
            .drive(self.rx.items) { tableview, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tableview.dequeueReusableCell(withIdentifier: "BlogListCell") as! BlogListCell
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
    }
}


// MARK: private
private extension BlogListView {
    
    func attribute() {
        self.backgroundColor = .systemBackground
        self.register(BlogListCell.self, forCellReuseIdentifier: "BlogListCell")
        self.separatorStyle = .singleLine
        self.rowHeight = 100
        self.tableHeaderView = headerView
    }
    
}
