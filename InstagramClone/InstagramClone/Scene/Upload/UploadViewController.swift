//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by 김나희 on 2021/12/12.
//

import UIKit
import SnapKit

class UploadViewController: UIViewController {
    private let uploadImage: UIImage
    private let uploadImageView = UIImageView()
    
    private lazy var uploadText: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15)
        // textview에는 Placeholder 없고 textfield에는 있으나 한줄만 작성 가능..
        // placeholder처럼 만들기!
        textView.text = "문구 입력..."
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 15.0)
        textView.delegate = self
        
        return textView
    }()
    
    init(uploadImage: UIImage) {
        self.uploadImage = uploadImage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigation()
        setupLayout()
        
        uploadImageView.image = uploadImage
    }
    
}

// placeholder처럼 만들기!
extension UploadViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
    }
}

// MARK: private
private extension UploadViewController {
    func setupNavigation(){
        navigationItem.title = "새 게시물"
        
        let leftBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapLeftBarButton))
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(title: "공유", style: .plain, target: self, action: #selector(didTapRightBarButton))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setupLayout(){
        [uploadImageView, uploadText]
            .forEach { view.addSubview($0) }
        
        let inset: CGFloat = 16.0
        
        uploadImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.width.equalTo(100.0)
            $0.height.equalTo(uploadImageView.snp.width)
        }
        
        uploadText.snp.makeConstraints {
            $0.leading.equalTo(uploadImageView.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.top.equalTo(uploadImageView.snp.top)
            $0.bottom.equalTo(uploadImageView.snp.bottom)
        }
        
    }
    
    @objc func didTapLeftBarButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapRightBarButton() {
        dismiss(animated: true)
    }
}
