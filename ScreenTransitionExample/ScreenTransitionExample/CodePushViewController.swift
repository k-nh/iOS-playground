//
//  CodePushViewController.swift
//  ScreenTransitionExample
//
//  Created by 김나희 on 2021/09/10.
//

import UIKit

class CodePushViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name{
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }

    }
    

    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
