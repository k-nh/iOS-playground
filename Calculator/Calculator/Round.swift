//
//  Round.swift
//  Calculator
//
//  Created by 김나희 on 2021/09/16.
//

import UIKit

@IBDesignable
class Round: UIButton {
    @IBInspectable var isRound:Bool = false{
        didSet{
            if isRound{
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }


}
