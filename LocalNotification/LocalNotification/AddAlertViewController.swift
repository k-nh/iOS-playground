//
//  AddAlertViewController.swift
//  LocalNotification
//
//  Created by 김나희 on 2021/10/04.
//

import UIKit

class AddAlertViewController: UIViewController{
    var pickedDate: ((_ date: Date) -> Void)?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        // 위에 선언한 클로저에 date picker의 시간 대입
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
