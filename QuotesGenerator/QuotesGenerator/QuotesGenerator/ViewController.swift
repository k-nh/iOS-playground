//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by 김나희 on 2021/09/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    let quotes = [
        Quote(content: "삶이 있는 한 희망은 있다", name: "키케로"),
        Quote(content: "산다는것 그것은 치열한 전투이다.", name: "로망로랑"),
        Quote(content: "하루에 3시간을 걸으면 7년 후에 지구를 한바퀴 돌 수 있다. ", name: "사무엘 존슨"),
        Quote(content: "신은 용기있는자를 결코 버리지 않는다 ", name: "켄러"),
        Quote(content: "피할수 없으면 즐겨라 ", name: "로버트 엘리엇")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapQuoteGeneratorButton(_ sender: Any) {
        let random = Int(arc4random_uniform(5)) //0~4사이
        let quote = quotes[random]
        self.quoteLabel.text = quote.content
        self.nameLabel.text = quote.name
        
    }
    
}

