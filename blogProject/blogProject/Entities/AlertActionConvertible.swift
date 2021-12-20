//
//  AlertActionConvertible.swift
//  blogProject
//
//  Created by 김나희 on 2021/12/19.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
