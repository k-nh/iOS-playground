//
//  AppDelegate.swift
//  CreditCardRecommendList
//
//  Created by 김나희 on 2021/09/24.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        
        //firestore db 선언
        let db = Firestore.firestore()
        db.collection("creditCardList").getDocuments { snapshot, _ in
            // data 확인 후 아무것도 없다면 넣어주기
            guard snapshot?.isEmpty == true else { return }
            let batch = db.batch()
            // card0Repf라는 collection에 card0 파일 경로 만들어주기 ..
            let card0Repf = db.collection("creditCardList").document("card0")
            let card1Repf = db.collection("creditCardList").document("card1")
            let card2Repf = db.collection("creditCardList").document("card2")
            let card3Repf = db.collection("creditCardList").document("card3")
            let card4Repf = db.collection("creditCardList").document("card4")
            let card5Repf = db.collection("creditCardList").document("card5")
            let card6Repf = db.collection("creditCardList").document("card6")
            let card7Repf = db.collection("creditCardList").document("card7")
            let card8Repf = db.collection("creditCardList").document("card8")
            let card9Repf = db.collection("creditCardList").document("card9")
            // batch 안에 객체 넣기
            do{
                try batch.setData(from: CreditCardDummy.card0, forDocument: card0Repf)
                try batch.setData(from: CreditCardDummy.card1, forDocument: card1Repf)
                try batch.setData(from: CreditCardDummy.card2, forDocument: card2Repf)
                try batch.setData(from: CreditCardDummy.card3, forDocument: card3Repf)
                try batch.setData(from: CreditCardDummy.card4, forDocument: card4Repf)
                try batch.setData(from: CreditCardDummy.card5, forDocument: card5Repf)
                try batch.setData(from: CreditCardDummy.card6, forDocument: card6Repf)
                try batch.setData(from: CreditCardDummy.card7, forDocument: card7Repf)
                try batch.setData(from: CreditCardDummy.card8, forDocument: card8Repf)
                try batch.setData(from: CreditCardDummy.card9, forDocument: card9Repf)
                
            } catch let error {
                print("ERROR writing card to Firestore \(error.localizedDescription)")
            }
            // 배치 반드시 commit해야 데이터 추가됨
            batch.commit()
            
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

