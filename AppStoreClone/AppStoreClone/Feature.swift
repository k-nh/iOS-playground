//
//  Feature.swift
//  AppStoreClone
//
//  Created by 김나희 on 2021/12/01.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
