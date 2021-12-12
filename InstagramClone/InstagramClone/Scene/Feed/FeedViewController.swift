//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by 김나희 on 2021/12/08.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    private lazy var feedTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .systemBackground
        // collectionview처럼 사용하기 위해
        tableview.separatorStyle = .none
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        
        return tableview
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.allowsEditing = true
        controller.delegate = self
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupTableViewLayout()
    }


}

extension FeedViewController: UITableViewDelegate{
    
}

extension FeedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell
        cell?.selectionStyle = .none
        cell?.setup()
        
        return cell ?? UITableViewCell()
    }
    
    
}

extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 이미지 선택 다음
        var selectedImage: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectedImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImage = originalImage
        }
        
        picker.dismiss(animated: true){ [weak self] in
            let uploadViewController = UploadViewController(uploadImage: selectedImage ?? UIImage())
            let navigationController = UINavigationController(rootViewController: uploadViewController)
            navigationController.modalPresentationStyle = .fullScreen
            
            self?.present(navigationController, animated: true, completion: nil)
        }
    }
}

// MARK: private
private extension FeedViewController {
    func setupNavigationController() {
        navigationItem.title = "Instagram"
        let uploadButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: #selector(didTabUploadButton)
        )
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    @objc func didTabUploadButton(){
        // imagePickerController
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    func setupTableViewLayout() {
        view.addSubview(feedTableView)
        feedTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
