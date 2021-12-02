//
//  AppDetailViewController.swift
//  AppStoreClone
//
//  Created by 김나희 on 2021/12/01.
//

import UIKit
import SnapKit
import Kingfisher

final class AppDetailViewController: UIViewController {
    private let today: Today
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        
        return imageView
    }()
    private lazy var appTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.0
        button.setTitle( "받기" , for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        imageView.tintColor = .systemBlue
        // 동작 구현
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        
        return button
    }()

    
    init(today: Today) {
        self.today = today
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 모드(라이트, 다크)에 맞게 실행이 되게
        view.backgroundColor = .systemBackground
        setupViews()
        
        if let imageURL = URL(string: today.imageURL){
            imageView.kf.setImage(with: imageURL)
        } else { imageView.backgroundColor = .lightGray }
        appTitleLabel.text = today.title
        subTitleLabel.text = today.subTitle
    }
    
}

// MARK: private
private extension AppDetailViewController {
    func setupViews(){
        [imageView, appTitleLabel, subTitleLabel, downloadButton, shareButton]
            .forEach { view.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.height.equalTo(100.0)
            $0.width.equalTo(imageView.snp.height)
        }
        appTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(16.0)
            $0.top.equalTo(imageView.snp.top)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(appTitleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(appTitleLabel.snp.leading)
        }
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom)
            $0.leading.equalTo(imageView.snp.trailing).offset(16.0)
            $0.height.equalTo(24.0)
            $0.width.equalTo(60.0)
        }
        shareButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(32.0)
            $0.width.equalTo(32.0)
            $0.bottom.equalTo(downloadButton.snp.bottom)
        }
        
    }
    
    @objc func didTapShareButton() {
        let activityItems:[Any] = [today.title]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }

}
