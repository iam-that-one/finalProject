//
//  ChatViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 01/01/2022.
//

import UIKit
import Firebase
class ChatViewController: UIViewController {
var myName = ""
    var v = false
    var userInfo : [User] = []
    var messages : [Message] = []
    var name = ""
    var status = false
    var offerProviderId = ""
    var initialMessage = ""
    var pic = Data()
    let db = Firestore.firestore()
    var offerProvider : Offer? = nil
    var offerProviderPofile : User? = nil
    

    lazy var chatTableView : UITableView = {
        $0.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    lazy var messageTf : UITextField = {
        $0.placeholder = ""
        $0.text = "Hi"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var newLable : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingTop = 40
        return $0
    }(PaddingLabel())
    
    lazy var sendButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(sentBtnClick), for: .touchDown)
        $0.tintColor = .darkGray
        $0.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        return $0
    }(UIButton(type: .system))
    
    lazy var backToOfferViewBtn : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(backToDetailsViewBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
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
        fetchMesssages()
        messageTf.text = initialMessage
        view.backgroundColor = .white
       // newLable.text! = offerProviderPofile!.name
        view.backgroundColor = UIColor.systemGray5
      //  setBackgroundImage(imageName: "chatBac")
        [messageTf,sendButton,newLable,chatTableView,backToOfferViewBtn].forEach{view.addSubview($0)}
      //  print("Offer provider id \(offerProvider!.userID)")
        getProfile(offerProviderId)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NSLayoutConstraint.activate([
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            backToOfferViewBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            backToOfferViewBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            
            chatTableView.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 30),
            chatTableView.widthAnchor.constraint(equalToConstant: 380),
            chatTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: messageTf.topAnchor,constant: -20),
                                                    
            messageTf.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 5),
            messageTf.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageTf.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-100),
            messageTf.heightAnchor.constraint(equalToConstant: 40),
            
            sendButton.leadingAnchor.constraint(equalTo: messageTf.trailingAnchor,constant: 10),
            sendButton.centerYAnchor.constraint(equalTo: messageTf.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        print("AAAAAAAAAAAAAAAAAA",offerProviderId)
    }
    @objc func sentBtnClick(){
        db.collection("offers_users").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { querySnapshot, error in
                if let error = error{
                    print(error)
                }else{
                   
                    for doc in querySnapshot!.documents{
                         let data = doc.data()
                        self.name = data["firstName"] as? String ?? ""
                        self.pic = data["image"] as? Data ?? Data()
                    }
                    
                
           
        
                    let msg = ["content": self.messageTf.text!, "id": Auth.auth().currentUser!.uid, "date" : SharedInstanceManager.shared.dateFormatter.string(from: Date()),"time":Timestamp() ,"Name" : self.name] as [String : Any]
           
                    self.db.collection("offers_users").document(Auth.auth().currentUser!.uid)
                        .collection("Message").document(self.offerProviderId).collection("msg").document().setData(msg as [String : Any])
               
               
                    self.db.collection("offers_users").document(self.offerProviderId)
            .collection("Message").document(Auth.auth().currentUser!.uid).collection("msg").document().setData(msg as [String : Any])
                    
                    self.db.collection("RecentMessages").document(Auth.auth().currentUser!.uid).setData(["senderId" : Auth.auth().currentUser!.uid, "reciverId": self.offerProviderId, "content": self.messageTf.text!, "date": Date()] as [String: Any])
                }
            }
        fetchMesssages()
      
    }
    @objc func backToDetailsViewBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    func setBackgroundImage(imageName: String){
          let background = UIImage(named: imageName)
          var imageView : UIImageView!
          imageView = UIImageView(frame: view.bounds)
          imageView.contentMode =  .scaleAspectFill
          imageView.clipsToBounds = true
          imageView.image = background
          imageView.center = view.center
          view.addSubview(imageView)
          self.view.sendSubviewToBack(imageView)
      }
    func fetchMesssages(){
        
        let name = db.collection("offers_users").document(Auth.auth().currentUser!.uid)
            name.getDocument { user, error in
                if let error = error{
                    print(error)
                }else{
                    if Auth.auth().currentUser?.uid == user?.get("ID") as? String{
                    self.myName = user?.get("Name") as! String
                    }
                    print("###########")
                    print(self.myName)
                }
            }
        
            db.collection("offers_users").document(Auth.auth().currentUser!.uid)
            .collection("Message").document(offerProviderId).collection("msg")
                .order(by: "time")
                .addSnapshotListener { (querySnapshot, error) in
                    self.messages = []
                    if let e = error {
                        print(e)
                    }else {
                        if let snapshotDocuments = querySnapshot?.documents{
                            for document in snapshotDocuments {
                                let data = document.data()
                                if  let msg = data["content"] as? String,
                                let id = data["id"] as? String,
                                    let date = data["date"] as? String,
                                    let name = data["Name"] as? String
                                {
                                    
                                    let finalDate = SharedInstanceManager.shared.dateFormatter.date(from: date)
                                    let fetchedMessage = Message(name: name, date: finalDate ?? Date(), userID: id, content: msg)
                                    self.messages.append(fetchedMessage)
                                    DispatchQueue.main.async {
                                        self.chatTableView.reloadData()
                                        print(self.messages)
                                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                        self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
        }
    func getProfile(_ id: String){
        db.collection("offers_users").whereField("uid", isEqualTo:id)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error while fetching profile\(error)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let phone = data["phoneNumnber"] as? String ?? ""
                            let firstName = data["firstName"] as! String
                            let isVerified = data["isVerified"] as? Bool ?? false
                           // let profilePic = data["image"] as! Data
                            self.userInfo.append(User(name: firstName, phoneNumber: phone, isVerified: isVerified))
                            self.newLable.text = firstName
                          
                            
                        }
                    }
                }
            }

    }
  
}

extension ChatViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! ChatTableViewCell
   
       // let date = dateFormatter.date(from: messages[indexPath.row].date)
        cell.username.text = messages.sorted{$0.date < $1.date}[indexPath.row].name
        cell.content.text = messages.sorted{$0.date < $1.date}[indexPath.row].content
        cell.date.text = SharedInstanceManager.shared.dateFormatter.string(from:messages.sorted{$0.date < $1.date}[indexPath.row].date )
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    // Move lofin view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillShow(view,-300)
    }

   
    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillHide(view)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
