//
//  featureSectionView.swift
//  AppStoreClone
//
//  Created by 김나희 on 2021/11/30.
//

import UIKit
import SnapKit

final class featureSectionView: UIView {
    private var featureList: [Feature] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // 가로 스크롤
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        // 화면 딱딱 나눠지게 스크롤 - 기본 false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        // 스크롤바 가리기
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(featureSectionCollectionViewCell.self, forCellWithReuseIdentifier: "featureSectionCollectionViewCell")
        
        return collectionView
    }()
    
    private let seperatorView = SeperatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UIViewController이면 viewdidload에서 부르겠지만, UIView이기 때문에 init에서 부름
        setupViews()
        
        // 데이터 가져온 뒤
        fetchData()
        // 컬렉션 뷰 다시 그려주기
        collectionView.reloadData()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension featureSectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: collectionView.frame.width)
    }
    
    // pagination 중앙 정렬을 위해
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    
    // section의 최소마진 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32.0
    }
    
    
    
}


extension featureSectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        featureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featureSectionCollectionViewCell", for: indexPath) as? featureSectionCollectionViewCell
        let feature = featureList[indexPath.item]
        cell?.setup(feature: feature)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = AppDetailViewController(today: featureList[indexPath.item])
        self.present(viewController, animated: true, completion: nil)
    }
    
}


private extension featureSectionView {
    func setupViews(){
        [
            collectionView,
            seperatorView
        ].forEach { addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(snp.width)
        }
        
        seperatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
        }
    }
    
    func fetchData(){
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else { return }
        
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            featureList = result
        } catch {}
    }
}
