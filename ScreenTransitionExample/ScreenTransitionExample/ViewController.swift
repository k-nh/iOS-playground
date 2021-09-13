//
//  ViewController.swift
//  ScreenTransitionExample
//
//  Created by 김나희 on 2021/09/10.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController 뷰가 로드 되었다. (viewDidLoad)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController 뷰가 나타날 것이다. (viewWillAppear)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController 뷰가 나타났다. (viewDidAppear)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController 뷰가 사라질 것이다. (viewWillDisappear)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController 뷰가 사라졌다. (viewDidDisappear)")
    }
    

    @IBAction func tapCodePushButton(_ sender: UIButton) {
        // identifier 매개변수 - storyboard id
        // 옵셔널로 넘겨주기 때문에 guard문 사용
        // downcasting -> name property에 접근 가능 - 데이터 전달
        guard let viewController1 = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") as? CodePushViewController else { return }
        viewController1.name = "hi"
        self.navigationController?.pushViewController(viewController1, animated: true)
    }
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        guard let viewController2 = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else { return }
        viewController2.modalPresentationStyle = .fullScreen
        viewController2.name = "hihi"
        // delegate 위임 -> sendData protocol 채택 해야함
        viewController2.delegate = self
        self.present(viewController2, animated: true, completion: nil)
    }
    
    
    /* segueway로 구현된 화면전환 방법에서 전환되는 화면에 값을 전달하기 위해 가장 좋은 위치는 전처리 prepare method이다.
     prepare method를 override 하면 segueway 실행 직전에 시스템에 의해 override된 prepare method가 자동 호출 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 전환하려는 view controller instance를 가져올 수 있음
        if let viewController3 = segue.destination as? SeguePushViewController {
            viewController3.name = "hihihi"
        }
    }
    
    
    func sendData(name:String) {
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
}

