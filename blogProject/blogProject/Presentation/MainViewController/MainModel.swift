//
//  MainModel.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/20.
//

import RxSwift
import Foundation

struct MainModel {
    let network = SearchBlogNetwork()
    
    func searchBlog(_ query: String) -> Single<Result<Blog, SearchNetworkError>> {
        return network.searchBlog(query: query)
    }
    
    func getBlogValue(_ result: Result<Blog, SearchNetworkError>) -> Blog? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getBlogError(_ result: Result<Blog, SearchNetworkError>) -> String? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error.localizedDescription
    }
    
    func getBlogListCellData(_ value: Blog) -> [BlogListCellData] {
        return value.documents
            .map { document in
                let thumnailURL = URL(string: document.thumbnail ?? "")
                return BlogListCellData(
                    thumbnailURL: thumnailURL,
                    name: document.name,
                    title: document.title,
                    datetime: document.datetime
                )
            }
    }
    
    func sort(by type: MainViewController.AlertAction, of data: [BlogListCellData]) -> [BlogListCellData] {
        switch type {
        case .title:
            return data.sorted { $0.title ?? "" < $1.title ?? ""}
        case .datetime:
            return data.sorted { $0.datetime ?? Date() > $1.datetime ?? Date()}
        default:
            return data
        }
    }
}
