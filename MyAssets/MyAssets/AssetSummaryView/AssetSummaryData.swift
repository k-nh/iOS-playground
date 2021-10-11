//
//  AssetSummaryData.swift
//  MyAssets
//
//  Created by 김나희 on 2021/10/11.
//

import SwiftUI

class AssetSummaryData: ObservableObject {
    @Published var assets: [Asset] = load("assets.json")
}

func load<T:Decodable>(_ filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else{
        fatalError(filename + "을 찾을 수 없습니다.")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch {
        fatalError(filename + "을 찾을 수 없습니다.")
    }
    
    do{
        let decorder = JSONDecoder()
        return try decorder.decode(T.self, from: data)
    } catch {
        fatalError(filename + "을 \(T.self)로 파싱할 수 없습니다.")
    }
}
