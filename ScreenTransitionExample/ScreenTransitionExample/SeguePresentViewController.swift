//
//  SeguePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 김나희 on 2021/09/10.
//

import UIKit

class SeguePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
     
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    
}
