//
//  SettingViewController.swift
//  LedBoard
//
//  Created by 김나희 on 2021/09/13.
//

import UIKit

protocol LEDBoardSettingDelegate : AnyObject {
    func changedSetting(text: String?, textColor:UIColor, backgroundColor:UIColor)
}

class SettingViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    weak var delegate: LEDBoardSettingDelegate?
    var textColor : UIColor = .yellow
    var backgroundColor : UIColor = .black
    var ledText : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // led 화면에서 전달된 값 초기화
        self.configureView()
    }
    
    private func configureView(){
        if let ledText = self.ledText{
            self.textField.text = ledText
        }
        self.changeTextColor(color: self.textColor)
        self.changeBackgroundColor(color: self.backgroundColor)
    }

    @IBAction func tapTextColorButton(_ sender: UIButton) {
        if sender == self.yellowButton {
            self.changeTextColor(color: .yellow)
            self.textColor = .yellow
        }else if sender == self.purpleButton{
            self.changeTextColor(color: .purple)
            self.textColor = .purple
        }else{
            self.changeTextColor(color: .green)
            self.textColor = .green
        }
    }
    
    @IBAction func tapBackgroundColorButton(_ sender: UIButton) {
        if sender == self.blackButton{
            self.changeBackgroundColor(color: .black)
            self.backgroundColor = .black
        }else if sender == self.blueButton{
            self.changeBackgroundColor(color: .blue)
            self.backgroundColor = .blue
        }else{
            self.changeBackgroundColor(color: .orange)
            self.backgroundColor = .orange
        }
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        self.delegate?.changedSetting(
            text: self.textField.text,
            textColor: self.textColor,
            backgroundColor: self.backgroundColor)
        // 이전 화면으로 이동
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColor(color: UIColor){
        //삼항 연산자 이용 - 눌린 컬러가 해당 컬러이면 alpha값 변경
        self.yellowButton.alpha = color == UIColor.yellow ? 1 : 0.2
        self.greenButton.alpha = color == UIColor.green ? 1: 0.2
        self.purpleButton.alpha = color == UIColor.purple ? 1: 0.2
    }
    
    private func changeBackgroundColor(color: UIColor){
        //삼항 연산자 이용 - 눌린 컬러가 해당 컬러이면 alpha값 변경
        self.blackButton.alpha = color == UIColor.black ? 1 : 0.2
        self.blueButton.alpha = color == UIColor.blue ? 1: 0.2
        self.orangeButton.alpha = color == UIColor.orange ? 1: 0.2
    }

}
