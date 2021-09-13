//
//  CodePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 김나희 on 2021/09/10.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(name:String)
}

class CodePresentViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    // delegate 패턴을 사용할때 delegate 변수 앞에는 weak 키워드 필요
    // 안붙여주게 되면 강한 순환 참조 -> 메모리 누수
    weak var delegate:SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name{
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "delegate")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
