//
//  ChatViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 31/12/2021.
//

import UIKit
import Firebase
class MessagesViewController: UIViewController {
    let db = Firestore.firestore()
    var ids = [""]
    var recntChates : [RecentChat] = []
    lazy var messagesTableView : UITableView = {
        $0.register(MessagsTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    lazy var newLable : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "محادثاتي"
        $0.backgroundColor = UIColor.systemGray6
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingTop = 40
        return $0
    }(PaddingLabel())
    override func viewWillAppear(_ animated: Bool) {
        getProfile()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // getProfile()
        [messagesTableView,newLable].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            messagesTableView.topAnchor.constraint(equalTo: newLable.bottomAnchor ,constant: 10),
            messagesTableView.widthAnchor.constraint(equalToConstant: 380),
            messagesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
    }
    func getProfile(){
        print("Starting fetch recent messages")
        db.collection("offers_users").document(Auth.auth().currentUser!.uid).collection(Auth.auth().currentUser!.uid).document().collection("Message").getDocuments { QuerySnapshot, error in
            if let error = error{
                
            }else{
                for doc in QuerySnapshot!.documents{
                    print(doc.documentID)
                }
            }
        }
    }
        
        
       
    
}
//    func getProfile(){
//        print("Inside")
//        db.collection("offers_users").document(Auth.auth().currentUser!.uid)
//        .collection("Message").document(Auth.auth().currentUser!.uid).collection("msg")
//
//            .addSnapshotListener { (querySnapshot, error) in
//
//                if let e = error {
//                    print(e)
//                }else {
//                    if let snapshotDocuments = querySnapshot?.documents{
//                        for document in snapshotDocuments {
//                            let data = document.data()
//                            if  let msg = data["content"] as? String,
//                            let id = data["id"] as? String,
//                                let date = data["date"] as? String,
//                                let _ = data["Name"] as? String
//                            {
//                                self.db.collection("offers_users").whereField("uid", isEqualTo:id)
//                                    .addSnapshotListener { (querySnapshot, error) in
//                                        if let error = error {
//                                            print("Error while fetching profile\(error)")
//                                        } else {
//                                            if let snapshotDocuments = querySnapshot?.documents {
//                                                for doc in snapshotDocuments {
//                                                    let data = doc.data()
//                                                    let name = data["firstName"] as? String ?? ""
//                                                    let image = data["image"] as? Data ?? Data()
//
//                                                    self.recntChates.append(RecentChat(name: name, content: msg, date: date, profilePic: image))
//                                                    print(self.recntChates)
//                                                    DispatchQueue.main.async {
//                                                        self.messagesTableView.reloadData()
//
//                                                }
//                                                }
//                                            }
//                                        }
//
//                                    }
//
//                        }
//                    }
//                }
//            }
//
//        }
//
//
//
//    }
    
   


extension MessagesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recntChates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "cell") as! MessagsTableViewCell
        cell.progilePic.image = UIImage(data: recntChates[indexPath.row].profilePic)
        cell.date.text = recntChates[indexPath.row].date
        cell.username.text = recntChates[indexPath.row].name
        cell.progilePic.image = UIImage(data: recntChates[indexPath.row].profilePic)
        return cell
    }
    
    
}


//
//func getProfile(){
//    print("Starting fetch recent messages")
//    db.collection("offers_users").addSnapshotListener { querySnapshot, error in
//
//
//        if let error = error{
//            print(error)
//        }else{
//
//            for doc in querySnapshot!.documents{
//                print(doc.documentID)
//            }
//        }
//    }
//}
//}
