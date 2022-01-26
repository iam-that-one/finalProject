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
    var status = false
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
        $0.text = "رسائلي"
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
        status = UserDefaults.standard.bool(forKey: "isDarkMode")
        
        if status{
            overrideUserInterfaceStyle = .dark
            
        }else{
            overrideUserInterfaceStyle = .light
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: newLable
                                         , action: #selector(UIInputViewController.dismissKeyboard))
        newLable.addGestureRecognizer(tap)
        
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
                var content = ""
                self.recntChates = []
                self.filterdResult = []
                for doc in querySnapshot!.documents{
                    let data = doc.data()
                    let date = data["date"] as? Date ?? Date()
                    let time = data["time"] as? Timestamp ?? Timestamp()
                    let reciverId = data["reciverId"] as? String ?? ""
                    print("reciver",reciverId)
                    let senderId = data["senderId"] as? String ?? ""
                    content = data["content"] as? String ?? ""
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
                                    let profilePic = data["image"] as? Data ?? Data()
                                    let name = data["firstName"] as? String ?? ""
                                    if self.ids.contains(id){
                                        print("Nof",name)
                                        self.recntChates.append(RecentChat(name: name, id: id, date: date, profilePic: profilePic,time: time, content: content))
                                        self.filterdResult = self.recntChates
                                        self.ids.removeAll{$0 == id}
                                        self.messagesTableView.reloadData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
 
    // Move lofin view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillShow(view, 0)
    }

    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillHide(view)
    }
    @objc func dismissKeyboard() {
        SharedInstanceManager.shared.dismissKeyboard(view)
    }
}

extension MessagesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "cell") as! MessagsTableViewCell
        cell.progilePic.image = UIImage(data: filterdResult.sorted{$0.date < $1.date}[indexPath.row].profilePic)
    //   let stringDate = SharedInstanceManager.shared.dateFormatter.string(from: filterdResult.sorted{$0.date < $1.date}[indexPath.row].date)
    //    cell.date.text = stringDate
        cell.username.text = filterdResult.sorted{$0.date < $1.date}[indexPath.row].name

        cell.progilePic.image =   UIImage(data: filterdResult.sorted{$0.date < $1.date}[indexPath.row].profilePic)
        
        if indexPath.row % 2 == 0{
            cell.contentView.backgroundColor = .lightGray
        }else{
            cell.contentView.backgroundColor = UIColor.systemGray5
        }
  
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
