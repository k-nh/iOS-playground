//
//  BearListViewController.swift
//  Brewery
//
//  Created by 김나희 on 2021/11/09.
//

import UIKit

class BeerListViewController: UITableViewController {
    var beerList = [Beer]()
    var dataTasks = [URLSessionTask]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션바 커스텀
        title = "Brewery"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // cell register
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 150
        // pagination
        tableView.prefetchDataSource = self
        
        fetchBeer(of: currentPage)
    }
}

// UITableView datasource, delegate
extension BeerListViewController: UITableViewDataSourcePrefetching {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell else { return UITableViewCell() }
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        
        return cell
    }
    
    // BeerDetailViewController 연결
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        indexPaths.forEach{
            if ($0.row + 1)/25 + 1 == currentPage {
                self.fetchBeer(of: currentPage)
            }
        }

    }

        
}

// 데이터 fetching
private extension BeerListViewController{
    // page마다 fetch
    func fetchBeer(of page: Int){
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
              // 요청된적 없는 url이여야함.
              dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 싱글톤 URLSessionDataTask
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  // 순환참조 방지
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                print("ERROR: URLSession data task \(error?.localizedDescription ?? "")")
                return
            }
            
            // response의 statusCode별 대처
            switch response.statusCode {
            case (200...299): // 성공
                // 받아온 beers 데이터 beerList에 추가, 다음 페이지로 이동
                self.beerList += beers
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (400...499): // 클라 에러
                print("""
                    ERROR: Client ERROR \(response.statusCode)
                    Response: \(response)
                """)
            case (500...599): // 서버 에러
                print("""
                    ERROR: Server ERROR \(response.statusCode)
                    Response: \(response)
                """)
            default: // 나머지
                print("""
                    ERROR: ERROR \(response.statusCode)
                    Response: \(response)
                """)
            }
        }
        dataTask.resume()
        // 실행된 작업은 dataTasks에 저장
        dataTasks.append(dataTask)
    }
}
