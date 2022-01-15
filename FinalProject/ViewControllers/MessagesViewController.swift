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
    var ids : [String] = []
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
        $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingTop = 40
        return $0
    }(PaddingLabel())
    override func viewWillAppear(_ animated: Bool) {
       // getProfile()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
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
        
        db.collection("RecentMessages").addSnapshotListener { querySnapshot, error in
            if let error = error{
                print(error)
            }else{
                self.recntChates = []
                self.filterdResult = []
                for doc in querySnapshot!.documents{
                    let data = doc.data()
                    let date = data["date"] as? Date ?? Date()
                    print(date)
                    let reciverId = data["reciverId"] as? String ?? ""
                    print("reciver",reciverId)
                    let senderId = data["senderId"] as? String ?? ""
                    print("sender", senderId)
                    
                    if reciverId == Auth.auth().currentUser!.uid{
                        self.ids.append(senderId)
                        self.db.collection("offers_users").addSnapshotListener { querySnapshot, error in
                            if let error = error{
                                print(error)
                            }else{
                                for doc in querySnapshot!.documents{
                                    print("idddddddddddddddd",doc.documentID)
                                    let data = doc.data()
                                    let id = data["uid"] as? String ?? ""
                                   // let date = data["date"] as? Date ?? Date()
                                    let profilePic = data["image"] as? Data ?? Data()
                                    let name = data["firstName"] as? String ?? ""
                                    
                                    print(self.ids)
                                    if self.ids.contains(id){
                                        print("Nof",name)
                                        self.recntChates.append(RecentChat(name: name, id: id, date: date, profilePic: profilePic))
                                        self.filterdResult = self.recntChates
                                       // self.ids.removeAll{$0 == senderId}
                                        self.ids.removeAll{$0 == id}
                                        self.messagesTableView.reloadData()
                                    }
                                }
                            }
                        }
                        
                    }
                }
              
                print(self.ids)
            }
        }
    }
    var dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm E, d MMM y"
          formatter.dateStyle = .medium
          formatter.timeStyle = .medium
          return formatter
      }()
}

    
   


extension MessagesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "cell") as! MessagsTableViewCell
        cell.progilePic.image = UIImage(data: filterdResult.sorted{$0.date < $1.date}[indexPath.row].profilePic)
        let stringDate = dateFormatter.string(from: filterdResult.sorted{$0.date < $1.date}[indexPath.row].date)
        cell.date.text = stringDate
        cell.username.text = filterdResult.sorted{$0.date < $1.date}[indexPath.row].name

        cell.progilePic.image =   UIImage(data: filterdResult.sorted{$0.date < $1.date}[indexPath.row].profilePic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatViewController()
        chatVC.offerProviderId = filterdResult.sorted{$0.date > $1.date}[indexPath.row].id
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
       messagesTableView.reloadData()
    }
    
}
