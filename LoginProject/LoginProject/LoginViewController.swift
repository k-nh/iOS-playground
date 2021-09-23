//
//  LoginViewController.swift
//  LoginProject
//
//  Created by 김나희 on 2021/09/20.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 세버튼 모두 동일 ui
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigation bar 숨기기
        navigationController?.navigationBar.isHidden = true
        // google sign in
        // 해당 viewcontroller에 웹뷰 띄운다고 선언
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    @IBAction func tapGoogleLoginButton(_ sender: UIButton) {
        // 구글로 로그인 진행
        GIDSignIn.sharedInstance().signIn()
        //firebase 인증
        
    }
    
    @IBAction func tapAppleLoginButton(_ sender: UIButton) {
    }
}
