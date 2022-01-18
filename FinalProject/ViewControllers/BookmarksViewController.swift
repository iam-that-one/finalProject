//
//  BookmarksViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 17/01/2022.
//

import UIKit
import Firebase
class BookmarksViewController: UIViewController {

    let db = Firestore.firestore()
    var offers : [Offer] = []
    lazy var offersTableView : UITableView = {
        $0.register(OffersTableViewCell.self, forCellReuseIdentifier: "cell")
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
        $0.text = "تفضيلاتي 🖤"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.paddingTop = 20
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(PaddingLabel())
    override func viewDidLoad() {
        super.viewDidLoad()
        [newLable,offersTableView].forEach{view.addSubview($0)}
        getMBookmarks()
        NSLayoutConstraint.activate([
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            offersTableView.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 10),
            offersTableView.widthAnchor.constraint(equalToConstant: 380),
            offersTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            offersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
    }
 
    func getMBookmarks(){
        db.collection("Bookmarks").whereField("id", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { querySnapshot, error in
            if let error = error{
                print(error)
            }else{
                for doc in querySnapshot!.documents{
                    let data = doc.data()
                 //   let id = data["id"] as? String ?? ""
                    let offerID = data["offerID"] as? String ?? ""
                   
                        self.db.collection("Offers").whereField("offerID", isEqualTo:offerID).addSnapshotListener { querySnapshot, error in
                            if let error = error{
                                print(error)
                            }else{
                                
                                for doc in querySnapshot!.documents{
                                    
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
                                    let lat = data["lat"] as? Double ?? 0.0
                                    let log = data["log"] as? Double ?? 0.0
                                  //  if id == Auth.auth().currentUser!.uid{
                                    self.offers.append(Offer(title: offerTitle, description: offerDes, price: price, userID: userID, offerID: offerID, date: self.dateFormatter.date(from: date) ?? Date(),lat: lat ,log: log, city: city, categoery: cat, image1: image1, image2: image2, image3: image3, image4: image4))
                               // }
                                self.offersTableView.reloadData()
                                
                            }
                        }
                    }
                    
                }
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

extension BookmarksViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count// Offer.example.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = offersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OffersTableViewCell
        cell.offerImage.image = UIImage(data:offers[indexPath.row].image1) ?? UIImage()
        cell.title.text = offers[indexPath.row].title
        //let date = dateFormatter.string(from: filterdResult[indexPath.row].date)
        cell.price.text = offers[indexPath.row].price + "ريال سعودي " + " "
        cell.date.text = offers[indexPath.row].date.timeAgoDisplay()
        cell.categoery.text = "#" + offers[indexPath.row].categoery
        cell.city.text = offers[indexPath.row].city
        if indexPath.row % 2 == 0{
            cell.contentView.backgroundColor = UIColor.lightGray //UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        }else{
            cell.contentView.backgroundColor = UIColor.systemGray5
        }
        return cell
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OfferDetailsViewController()
        vc.offer = offers[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
