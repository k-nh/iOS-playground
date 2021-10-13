//
//  MainViewController.swift
//  LoginProject
//
//  Created by 김나희 on 2021/09/20.
//

import UIKit
import FirebaseAuth

class MainViewController:UIViewController{
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        let email = Auth.auth().currentUser?.email ?? "고객"
        // 애플 로그인에서 이메일 가리기 선택시 프로필 이름 생성 가능하게
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        // 이메일, 비밀번호로 로그인 했는지 확인
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn  // 이메일, 비밀번호로 로그인 하지않았다면 버튼 숨기기
    }
    @IBAction func tapLogoutButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true) //루트화면으로 넘어가기
        }catch let signOutError as NSError{
            print("ERROR : signout \(signOutError.localizedDescription)")
        }
    }
    @IBAction func tapResetPasswordButton(_ sender: UIButton) {
        let email = Auth.auth().currentUser?.email ?? ""
        // 비밀번호 리셋 - 해당 이메일에 비밀번호 변경 메일 전송
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
    @IBAction func tapProfileUpdateVButton(_ sender: UIButton) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "바꿈"
        changeRequest?.commitChanges { _ in
            let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객"
            
            self.welcomeLabel.text = """
                환영합니다.
                \(displayName)님
                """
        }
    }
}

