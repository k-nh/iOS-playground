//
//  SearchBlogNetwork.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/19.
//

import RxSwift
import Foundation

enum SearchNetworkError: Error {
    case invalidJSON
    case networkError
    case invalidURL
}

class SearchBlogNetwork {
    private let session: URLSession
    
    let api = SearchBlogAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchBlog(query: String) -> Single<Result<Blog, SearchNetworkError>> {
        guard let url = api.searchBlog(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK a0ca7148e25c957ad4bef008f51671e3", forHTTPHeaderField: "Authorization")

        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(Blog.self, from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                .just(.failure(.networkError))
            }
            .asSingle()
    }
}
