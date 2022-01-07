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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        db.collection("offers_users").whereField("uid", isEqualTo:Auth.auth().currentUser!.uid)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error while fetching profile\(error)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let firstName = data["firstName"] as! String
                           // self.username.text = firstName
                          //  self.email.text = Auth.auth().currentUser!.email
                          //  let profilePic = data["image"] as! Data
                          //  self.profPic.image = UIImage(data: profilePic)
                            
                        }
                    }
                }
            }
    }
    
    func getMyOffers(){
        db.collection("Offers").whereField("userID", isEqualTo:Auth.auth().currentUser!.uid)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error while fetching profile\(error)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let userID = data["userID"] as? String ?? ""
                            let offerID = data["offerID"] as? String ?? ""
                            let date = data["date"] as? String ?? ""
                            let offerTitle = data["offerTitle"] as? String ?? ""
                            let offerDes = data["offerDes"] as? String ?? ""
                            let price = data["price"] as? String ?? ""
                            let city = data["city"] as? String ?? ""
                            let cat = data["cate"] as? String ?? ""
                            let image1 = data["image1"] as? Data ?? Data()
                            let image2 = data["image2"] as? Data ?? Data()
                            let image3 = data["image3"] as? Data ?? Data()
                            let image4 = data["image4"] as? Data ?? Data()
                            
                           // self.myOffers.append(Offer(title: offerTitle, description: offerDes, price: price, userID: userID, offerID: offerID, date: date, city: city, categoery: cat, image1: image1, image2: image2, image3: image3, image4: image4))
                        }
                       // self.profileOffersTableView.reloadData()
                        
                      
                    }
                }
            }
    }
}

extension MessagesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "cell") as! MessagsTableViewCell
        cell.progilePic.image = UIImage(systemName: "person.circle.fill")
        return cell
    }
    
    
}
