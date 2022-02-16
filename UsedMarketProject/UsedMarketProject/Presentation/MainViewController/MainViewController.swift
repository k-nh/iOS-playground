//
//  MainViewController.swift
//  UsedMarketProject
//
//  Created by 김나희 on 2021/12/27.
//

import UIKit
import SnapKit
import RxSwift

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    let submitButton = UIBarButtonItem()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MainViewModel) {
        // MARK: viewmodel에서 전달받은 것 구현
        viewModel.cellData
            .drive(tableView.rx.items) { tableView, row, data in
                switch row { // row에 따라 cell 다 다름
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTextFieldCell", for: IndexPath(row: row, section: 0)) as! TitleTextFieldCell
                    cell.selectionStyle = .none
                    cell.titleInputField.placeholder = data // placeholder로 전달받은 데이터 넣기
                    cell.bind(viewModel.titleTextFieldCellViewModel)
                    
                    return cell
                    
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CategorySelectCell", for: IndexPath(row: row, section: 0))
                    cell.selectionStyle = .none // 선택했을때 회색음영 없게
                    cell.textLabel?.text = data
                    cell.accessoryType = .disclosureIndicator // 꺽쇄 모양 넣기
                    
                    return cell
                    
                case 2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTextFieldCellView", for: IndexPath(row: row, section: 0)) as! PriceTextFieldCellView
                    cell.selectionStyle = .none
                    cell.priceInputField.placeholder = data
                    cell.bind(viewModel.priceTextFieldCellViewModel)
                    
                    return cell
                    
                case 3:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DetailWriteFormCell", for: IndexPath(row: row, section: 0)) as! DetailWriteFormCell
                    cell.selectionStyle = .none
                    cell.contentInputView.text = data
                    cell.bind(viewModel.detailWriteFormCellViewModel)
                    
                    return cell
                    
                default:
                    fatalError()
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.presentAlert
            .emit(to: self.rx.setAlert)
            .disposed(by: disposeBag)
        
        viewModel.push
            .drive(onNext: { viewModel in
                let viewController = CategoryListViewController()
                viewController.bind(viewModel)
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        
        // MARK: viewmodel에 전달
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .bind(to: viewModel.submitButtonTapped)
            .disposed(by: disposeBag)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

// MARK: private
extension MainViewController {
    func setupAttribute(){
        title = "중고거래 글쓰기"
        view.backgroundColor = .systemBackground
        
        submitButton.title = "제출"
        submitButton.style = .done
        
        navigationItem.setRightBarButton(submitButton, animated: true)
        
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        // cell이 더 없으면 footerView -> separtor 보이지 x
        tableView.tableFooterView = UIView()
        
        // 각 셀들 등록
        // index row = 0,1,2,3번
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategorySelectCell")
        tableView.register(PriceTextFieldCellView.self, forCellReuseIdentifier: "PriceTextFieldCellView")
        tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: "DetailWriteFormCell")
        
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

typealias Alert = (title:String, message: String?)

extension Reactive where Base: MainViewController {
    var setAlert: Binder<Alert> {
        return Binder(base) { base, data in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            let alert = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(alert)
            base.present(alertController, animated: true, completion: nil)
        }
    }
}
