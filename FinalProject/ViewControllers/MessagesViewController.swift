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
    var filterdResult : [RecentChat] = []
    var offers : [Offer] = []
    var userId = ""
    lazy var searchBar : UISearchBar = {
        $0.placeholder = "بحث"
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
      return $0
    }(UISearchBar())
    
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
        [messagesTableView,newLable,searchBar].forEach{view.addSubview($0)}
        filterdResult = recntChates
        NSLayoutConstraint.activate([
            
            
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            searchBar.topAnchor.constraint(equalTo: newLable.bottomAnchor ,constant: 10),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            
            messagesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor ,constant: 10),
            messagesTableView.widthAnchor.constraint(equalToConstant: 380),
            messagesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
    }
    
    func getProfile(){
        
        db.collection("offers_users").getDocuments { querySnapshot, error in
            if let error = error{
                print(error)
            }else{
                self.recntChates = []
                for doc in querySnapshot!.documents{
                    let data = doc.data()
                    let id = data["uid"] as? String ?? ""
                    let name = data["firstName"] as? String ?? ""
                    var pic = data["image"] as? Data ?? Data()
                    if pic.count == 0{
                        pic = UIImage(systemName: "person.circle.fill")!.pngData() ?? Data()
                    }
                    self.recntChates.append(RecentChat(name: name, id: id, profilePic: pic))
                    self.userId = id
                    self.filterdResult = self.recntChates
                    self.messagesTableView.reloadData()
                }
            }
        }
    }
  
//    func getProfile(){
//        print("Starting fetch recent messages")
//        db.collection("offers_users").document(Auth.auth().currentUser!.uid).collection("Message").getDocuments { querySnapshot, error in
//            if let error = error{
//                print(error)
//            }else{
//                for doc in querySnapshot!.documents{
//                    let data = doc.data()
//                    print(data)
//                }
//            }
//        }
//    }
        
        
       
    
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
        return filterdResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "cell") as! MessagsTableViewCell
        cell.progilePic.image = UIImage(data: filterdResult[indexPath.row].profilePic)
       // cell.date.text = recntChates[indexPath.row].date
        cell.username.text = filterdResult[indexPath.row].name
        cell.progilePic.image =  UIImage(data: filterdResult[indexPath.row].profilePic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatViewController()
        chatVC.offerProviderId = recntChates[indexPath.row].id
       // print("AAAAAAAAAAAAAAAA",self.userId)
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
}


extension MessagesViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterdResult = []
        
        if searchText == ""{
           filterdResult = recntChates
        }
        else{
        for chat in recntChates{
            if chat.name.lowercased().contains(searchText.lowercased()){
                filterdResult.append(chat)
            }
        }
    }
       // getOffers()
       messagesTableView.reloadData()
    }
    
}
