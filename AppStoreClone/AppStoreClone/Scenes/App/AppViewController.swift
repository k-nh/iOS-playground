//
//  AppViewController.swift
//  AppStoreClone
//
//  Created by 김나희 on 2021/11/30.
//

import UIKit
import SnapKit

final class AppViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical  // 세로 스크롤이기 때문
        
        // 스택 뷰의 각 크기가 다르기 때문에 간격만 동일하게 해주고 0.0으로 설정하여
        // 스택 뷰의 subView의 크기에 의해 크기가 정해지도록
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        let featureSectionView = featureSectionView(frame: .zero)  // init(frame:) 메소드
        let rankingFeatureSectionView = RankingFeatureSectionView(frame: .zero)
        let exchangeCodeButtonView = exchangeCodeButtonView(frame: .zero)
    
        // 임의의 뷰 추가하여 스크롤 뷰 아래화면 끝까지 잘보이게
        let spacingView = UIView()
        spacingView.snp.makeConstraints {
            $0.height.equalTo(100.0)
        }
                
        [featureSectionView, rankingFeatureSectionView, exchangeCodeButtonView, spacingView]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupLayout()
    }
    
}

// view 설정
private extension AppViewController {
    func setupNavigationController(){
        navigationItem.title = "앱"
        // 무조건 largeTitle로만 표시되게
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func setupLayout(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            // 세로 스크롤만 가능하게 - 가로만 고정
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}

