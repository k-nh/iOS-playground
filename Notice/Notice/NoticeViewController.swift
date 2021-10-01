//
//  NoticeViewController.swift
//  Notice
//
//  Created by 김나희 on 2021/09/30.
//

import UIKit

class NoticeViewController: UIViewController {
    var noticeContents: (title:String, detail:String, date:String)?

    @IBOutlet weak var noticeView: UIView!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noticeView.layer.cornerRadius = 6
        view.backgroundColor = UIColor.black
            .withAlphaComponent(0.5)
        
        guard let noticeContents = noticeContents else { return }
        titleLabel.text = noticeContents.title
        detailLabel.text = noticeContents.detail
        dateLabel.text = noticeContents.date
    }

    @IBAction func tapDoneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
