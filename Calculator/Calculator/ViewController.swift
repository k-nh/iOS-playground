//
//  ViewController.swift
//  Calculator
//
//  Created by 김나희 on 2021/09/16.
//

import UIKit

enum Operation{
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class ViewController: UIViewController {


    @IBOutlet weak var numberOutputLabel: UILabel!
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func tapClearButton(_ sender: UIButton) {
        // 모든 프로퍼티 초기화
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.numberOutputLabel.text = "0"
    }
    
    // 여러개의 숫자 버튼 - 하나의 액션 함수로 처리
    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return }
        // 숫자는 9자리까지만 가능
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        // 소수점 포함 아홉자리까지만 가능, 점 중복 안되게
        if self.displayNumber.count < 8, !self.displayNumber.contains("."){
            // 삼항연산자 이용 - 비어있다면 0. 아니면 .
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
        self.operation(.Divide)
    }
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    @IBAction func tapAddButton(_ sender: UIButton) {
        self.operation(.Add)
    }
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    @IBAction func tapEqulButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    // 계산 담당 함수
    func operation(_ operation: Operation) {
        if self.currentOperation != .unknown {
            if !self.displayNumber.isEmpty{
                self.secondOperand = self.displayNumber
                // 결과값 출력해야하기 때문
                self.displayNumber = ""
                // firstOperand,secondOperand 문자열을 실수형으로
                guard let firstOperand = Double(self.firstOperand) else {
                    return
                }
                guard let secondOperand = Double(self.secondOperand) else {
                    return
                }
                // 첫번째 피연산자와 두번째 피연산자 연산
                switch self.currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                default:
                    break
                }
                // ~.0 인 경우(1로 나눴을때 나머지 0) - int형으로 출력하게
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0{
                    self.result = "\(Int(result))"
                }
                // 다음 연산을 위해 firstOperand에 결과값을 대입 -> 누적 연산 가능하게끔
                self.firstOperand = self.result
                // 결과값 출력
                self.numberOutputLabel.text = self.result
            }
            self.currentOperation = operation
        }else{
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            // 새로운 숫자를 받아야하기때문
            self.displayNumber = ""
        }
    }
}

