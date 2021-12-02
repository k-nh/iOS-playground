//
//  TodayViewController.swift
//  AppStoreClone
//
//  Created by 김나희 on 2021/11/30.
//

import UIKit
import SnapKit

final class TodayViewController: UIViewController{
    private var todayList:[Today] = []
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: "todayCell")
        collectionView.register(TodayCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayCollectionViewHeader")
        
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 이 프로젝트에서는 데이터가 계속 업데이트 되지 않기 때문에 viewWillAppear가 아닌 viewDidLoad에서 진행
        fetchData()
    }
}

extension TodayViewController : UICollectionViewDataSource {
    // cell 개수 : numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        todayList.count
    }
    
    // cell item : cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as? TodayCollectionViewCell
        
        let today = todayList[indexPath.item]
        cell?.setup(today: today)
        
        return cell ?? UICollectionViewCell()
    }
    
    // 헤더나 풋터 리턴해주는 메소드 : viewForSupplementaryElementOfKind
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 헤더일때만
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodayCollectionViewHeader", for: indexPath) as? TodayCollectionViewHeader
        else{
            return UICollectionReusableView()
        }
        
        header.setupViews()
        
        return header
    }
    
    
}

extension TodayViewController : UICollectionViewDelegateFlowLayout {
    // cell 사이즈 : sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 왼, 오, 위, 아래 16씩 공간남게
        let size: CGFloat = collectionView.frame.width - 32.0
        return CGSize(width: size, height: size)
    }
    
    
    // 헤더 사이즈 : referenceSizeForHeaderInSection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width-32.0, height: 100)
    }
    
    // 헤더와 cell 사이 inset 설정 : insetForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value:CGFloat = 16.0
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = AppDetailViewController(today: todayList[indexPath.item])
        self.present(viewController, animated: true, completion: nil)
    }
}


private extension TodayViewController {
    func fetchData() {
        // plist 경로
        guard let url = Bundle.main.url(forResource: "Today", withExtension: "plist") else { return }
        
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Today].self, from: data)
            todayList = result
        } catch {}
        
    }
}
