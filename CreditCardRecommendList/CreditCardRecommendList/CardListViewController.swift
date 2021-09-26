//
//  CardListViewController.swift
//  CreditCardRecommendList
//
//  Created by 김나희 on 2021/09/24.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestore

class CardListViewController: UITableViewController{
    // var ref: DatabaseReference! // firebase realtime database를 가져올 레퍼런스
    var db = Firestore.firestore()
    
    var creditCardList:[CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UITableView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        

//        realtime database 읽기
//        ref = Database.database().reference()
//        ref.observe(.value) { snapshot in
//            guard let value = snapshot.value as? [String: [String:Any]] else { return }
//            // json decoding
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
//                // dictionary에서 value값만
//                let cardList = Array(cardData.values)
//                // 순위 기준으로 정렬
//                self.creditCardList = cardList.sorted { $0.rank < $1.rank }
//
//                // table view reload - ui움직임(main 스레드에서 해당 액션 넣어줌)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
//            } catch let error{
//                print("ERROR JSON parsing \(error.localizedDescription)")
//            }
//        }
        
        // firestore database 읽기
        db.collection("creditCardList").addSnapshotListener { snapshot, error in
            guard let document = snapshot?.documents else {
                print("ERROR Firestore fetching document \(String(describing: error))")
                return
            }
            
            self.creditCardList = document.compactMap { doc -> CreditCard? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                } catch let error {
                    print("ERROR JSON Parsing \(error)")
                    return nil
                }
            }.sorted { $0.rank < $1.rank }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell",for: indexPath) as? CardListCell else { return UITableViewCell() }
        
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        // kingfisher -> img url로 img 로드하는 라이브러리
        let imgURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imgURL)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 상세화면 전달
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "CardDetailViewController") as? CardDetailViewController else {
            return
        }
        
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
        
        // realtime database 쓰기
        // option1 : 경로를 알고있을때
        //let cardID = creditCardList[indexPath.row].id
        //ref.child("Item\(cardID)/isSelected").setValue(true)
        
        //option2 : 경로를 모를때
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//            guard let self = self,
//                  let value = snapshot.value as? [String: [String:Any]],
//                  let key = value.keys.first else { return }
//            self.ref.child("\(key)/isSelected").setValue(true)
//
//        }
        
        // firestore database 쓰기
        // option1 : 경로를 알고있을때
        let cardID = creditCardList[indexPath.row].id
        //db.collection("creditCardList").document("card\(cardID)").updateData(["isSelected": true])
        
        // option2 : 경로를 모를때
        db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents.first else {
                print("ERROR Firestore fetching document")
                return
            }
            document.reference.updateData(["isSelected": true])
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            // realtime database 삭제
            //option1 : 경로를 알고있을때
//            let cardID = creditCardList[indexPath.row].id
//            //ref.child("Item\(cardID)").removeValue()
//
//            //option2 : 경로를 모를때
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value){ [weak self] snapshot in
//                guard let self = self,
//                      let value = snapshot.value as? [String: [String:Any]],
//                      let key = value.keys.first else { return }
//                self.ref.child(key).removeValue()
//            }
            
            // firestore database 삭제
            // option1 : 경로를 알고있을때
            let cardID = creditCardList[indexPath.row].id
            //db.collection("creditCardList").document("card\(cardID)").delete()
            // option2 : 경로를 모를때
            db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, _ in
                guard let document = snapshot?.documents.first else{
                    print("ERROR Delete")
                    return
                }
                document.reference.delete()
            }
        }
    }
}
