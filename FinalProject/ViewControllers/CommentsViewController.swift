//
//  CommentsViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 10/01/2022.
//

import UIKit
import Firebase
class CommentsViewController: UIViewController {
    let db = Firestore.firestore()
    var comments : [Comment] = []
    var name = ""
    var offerID = ""

    lazy var myView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    lazy var sendComment : UITextField = {
        $0.placeholder = ""
        $0.text = "Hi"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var sendButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(sentBtnClick), for: .touchDown)
        $0.tintColor = .darkGray
        $0.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        return $0
    }(UIButton(type: .system))
    
    lazy var commentsTableView : UITableView = {
        $0.register(CommentsTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(commentsTableView)
        view.addSubview(sendComment)
        view.addSubview(sendButton)
        view.backgroundColor = .white
        getComments()
        NSLayoutConstraint.activate(
        [
            commentsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            commentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            commentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            sendButton.topAnchor.constraint(equalTo: commentsTableView.bottomAnchor,constant: 20),
            sendComment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sendComment.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            sendComment.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor,constant: -10),
            sendComment.widthAnchor.constraint(equalToConstant: 300),
            
            sendButton.leadingAnchor.constraint(equalTo: sendComment.trailingAnchor,constant: 10),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
            
        ]
        )
        // Do any additional setup after loading the view.
    }
    
    @objc func sentBtnClick(){
        send()
    }
    func send(){
        db.collection("Comments").document().setData(["comment" : sendComment.text!, "date": dateFormatter.string(from: Date()),"id" : offerID, "username":self.name] as [String:Any])
        getComments()
    }
    func getComments(){
        
        db.collection("offers_users").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { querySnapshot, error in
                if let error = error{
                    print(error)
                }else{
                   
                    for doc in querySnapshot!.documents{
                         let data = doc.data()
                        self.name = data["firstName"] as? String ?? ""
                    }
                    
                    self.db.collection("Comments")
                        .whereField("id", isEqualTo: self.offerID)
            .addSnapshotListener { (querySnapshot, error) in
                self.comments = []
                if let error = error {
                    print("Error while fetching profile\(error)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let username = data["username"] as? String ?? ""
                            let comment = data["comment"] as? String ?? ""
                            let date = data["date"] as? String ??  ""
                            
                            self.comments.append(Comment(username: username, dat: date, comment: comment))
                            self.commentsTableView.reloadData()
                        }
                        
                    }
                    
                }
            }}
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

extension CommentsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CommentsTableViewCell
        cell.username.text = comments[indexPath.row].username
        cell.content.text = comments[indexPath.row].comment
        let stringDate = comments[indexPath.row].dat
        cell.date.text = stringDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
