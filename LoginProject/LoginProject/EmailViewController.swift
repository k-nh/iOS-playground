//
//  EmailViewController.swift
//  LoginProject
//
//  Created by 김나희 on 2021/09/20.
//

import UIKit
import FirebaseAuth

class EmailViewController:UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 30
        // 이메일 비번 입력 x -> 비활성화
        nextButton.isEnabled = false
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // 이메일필드에 커서
        emailTextField.becomeFirstResponder()
   }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //nav바 보이기
        navigationController?.navigationBar.isHidden = false
    }
    @IBAction func tapNextButton(_ sender: UIButton) {
        // firebase 이메일, 비번 인증 / 빈 값이라면 ""로 옵셔널 처리
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        // 유저 create , [weak self] - 순환참조방지
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
            guard let self = self else {return}
            if let error = error{
                let code = (error as NSError).code
                switch code {
                case 17007: // 이미 가입한 계정일때
                    // 로그인하기
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            }else{
                // 계정 생성 -> 메인으로 넘어가기
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            }else{
                self.showMainViewController()
            }
            
        }
    }
}
extension EmailViewController:UITextFieldDelegate{
    // 리턴 버튼이 눌렸을때 키보드 내려가게
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    // 다음 버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
