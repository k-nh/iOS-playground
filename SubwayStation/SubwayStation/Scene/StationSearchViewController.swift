//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by 김나희 on 2021/12/02.
//

import Alamofire
import UIKit
import SnapKit

class StationSearchViewController: UIViewController {
    private var stations: [Station] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.isHidden = true
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        setTableViewLayout()
        //requestStationName()
    }

}

extension StationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 커스텀 셀 x
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let station = stations[indexPath.row]
        cell.textLabel?.text = station.stationName
        // subtitle 스타일
        cell.detailTextLabel?.text = station.lineNumber
        
        return cell
    }
}

extension StationSearchViewController: UISearchBarDelegate {

    // 서치바에 커서가 있을때만 tableview visible
    // 서치바에 editting 시작했을때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
        tableView.isHidden = false
    }
    // 서치바에 editting 끝났을때
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        stations = []
    }
    
    // 서치바에 한글자 입력,삭제할때 자동으로 불려지는 메소드
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // searchText로 request 메소드 부르기
        requestStationName(from: searchText)
    }
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        let viewController = StationDetailViewController(station: station)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: private
private extension StationSearchViewController {
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요."
        // search바 눌렀을때 배경 어둡지 않게
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    private func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func requestStationName(from stationName:String) {
        let urlString = "http://openapi.seoul.go.kr:8088/4545786678736b673130305464417951/json/SearchInfoBySubwayNameService/1/5/\(stationName)/"
        
        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationResponseModel.self) { [weak self] response in
                guard
                    let self = self,
                    case .success(let data) = response.result else { return }
                
                self.stations = data.stations
                self.tableView.reloadData()
            }
            .resume()
    }
}
