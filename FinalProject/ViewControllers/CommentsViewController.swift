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
    var status = false
    lazy var newLable : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "التعليقات"
        $0.textColor = .black
        $0.backgroundColor = UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingTop = 40
        return $0
    }(PaddingLabel())
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
        $0.backgroundColor = UIColor.lightGray
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    override func viewWillAppear(_ animated: Bool) {
        status = UserDefaults.standard.bool(forKey: "isDarkMode")
        
        if status{
            overrideUserInterfaceStyle = .dark
            
        }else{
            overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(commentsTableView)
        view.addSubview(sendComment)
        view.addSubview(sendButton)
        view.addSubview(newLable)
       // view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        getComments()
        NSLayoutConstraint.activate(
        [
            
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            commentsTableView.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 20),
            commentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            commentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            sendButton.topAnchor.constraint(equalTo: commentsTableView.bottomAnchor,constant: 20),
            sendComment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            sendComment.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            sendComment.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor,constant: -10),
            sendComment.widthAnchor.constraint(equalToConstant: 300),
            
            sendButton.leadingAnchor.constraint(equalTo: sendComment.trailingAnchor,constant: 10),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
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
        //db.collection("offers_users").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { [self] querySnapshot, error in
          //  if let error = error{
            //    print(error)
           // }else{
            //    for doc in querySnapshot!.documents{
             //       let data = doc.data()
                //    let name = data["firstName"] as? String ?? ""//
                
         
                    self.db.collection("Comments").document().setData(["comment" : sendComment.text!, "date": SharedInstanceManager.shared.dateFormatter.string(from: Date()),"id" : self.offerID, "username":self.name, "time": Timestamp(), "name": name] as [String:Any])
               // }
       //     }
      //  }
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
                        .order(by: "time")
                        .whereField("id", isEqualTo: self.offerID)
                       
            .addSnapshotListener { (querySnapshot, error) in
              //
                self.comments = []
                if let error = error {
                    print("Error while fetching profile\(error)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let username = data["username"] as? String ?? ""
                            let comment = data["comment"] as? String ?? ""
                            let date = data["date"] as? String ?? ""
                            self.comments.append(Comment(username: username, dat: date, comment: comment))
                            self.commentsTableView.reloadData()
                            self.newLable.text! = "التعليقات \n\n\(self.comments.count)"
                        }
                        if self.comments.count > 0{
                        let indexPath = IndexPath(row: self.comments.count - 1, section: 0)
                        self.commentsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                    }
                    
                }
            }
                    
                }
            }
    }
    
   
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
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    // Move lofin view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -320
    }

    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
