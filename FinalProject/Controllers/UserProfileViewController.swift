//
//  UserProfileViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 19/05/2022.
//

import UIKit
import Firebase
class UserProfileViewController: UIViewController {

    var userId = ""
    var userName = ""
    var profilePic = Data()
    var userOffers : [Offer] = []
    let db = Firestore.firestore()
    
//    lazy var profileOffersTableView : UITableView = {
//        $0.register(profileTableViewCell.self, forCellReuseIdentifier: "cell")
//        $0.rowHeight = UITableView.automaticDimension
//        $0.estimatedRowHeight = 600
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.delegate = self
//        $0.dataSource = self
//        $0.layer.cornerRadius = 10
//        $0.separatorStyle = .none
//        return $0
//    }(UITableView())
//
    
    lazy var bio : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "أهلاً بكم في حسابي. أتمنى أن تعجبكم عروضي."
        $0.textColor = .black
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    lazy var container : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.borderColor = CGColor.init(gray: 0.90, alpha: 1)
        $0.layer.borderWidth = 3
        return $0
    }(UIView())
    
    lazy var profileImage : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "pngwing.com")
        $0.tintColor = .white
        return $0
    }(UIImageView(frame: CGRect(x:0,y: 0,width: 100,height: 100)))
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var myColletionView : UICollectionView = {
        $0.backgroundColor = UIColor.white
        $0.dataSource = self
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        return $0
    }(UICollectionView(frame: self.view.frame, collectionViewLayout: layout))
    
 

    
    lazy var newLable : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "جميع عروض هذا المستخدم"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        $0.clipsToBounds = true
        $0.backgroundColor = .systemTeal//UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.paddingTop = 50
        $0.paddingBottom = 10
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return $0
    }(PaddingLabel())
    
    lazy var backToOfferViewBtn : UIButton = {
        $0.tintColor = .black
        $0.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(backToOfferViewBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSettings()
        getOffers()
        newLable.text = "أنا \(userName) حياك الله في حسابي"
        profileImage.image = UIImage(data: profilePic) 
        layout.estimatedItemSize = .init(width: 100, height: 100)
        print("corner",profileImage.frame.size.height / 2)
        profileImage.layer.cornerRadius = 40//profileImage.frame.size.height / 2
        profileImage.layer.masksToBounds = true
        bio.text = " أنا \(userName) أهلاً بكم في حسابي. أتمنى لكم تسوقاً ممتعاً. يرجى مزاسلتي على الخاص عند  اهتمامك بأحد عروضي."
      //  profileImage.clipsToBounds = true
    }
    
    func uiSettings(){
        view.backgroundColor = .white
        [profileImage,bio].forEach{container.addSubview($0)}
        [newLable,backToOfferViewBtn,myColletionView,container].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            
            backToOfferViewBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            backToOfferViewBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            backToOfferViewBtn.heightAnchor.constraint(equalToConstant: 40),
            backToOfferViewBtn.widthAnchor.constraint(equalToConstant: 30),
            
            container.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 30),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: 200),
            
            profileImage.topAnchor.constraint(equalTo: container.topAnchor,constant: 20),
            profileImage.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -20),
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            
            bio.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 30),
            bio.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -20),
            bio.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 20),
            bio.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -10),
            
            myColletionView.topAnchor.constraint(equalTo: container.bottomAnchor,constant: 20),
            myColletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            myColletionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            myColletionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 120)
            ])
    }
    @objc func backToOfferViewBtnClick(){
        navigationController?.popViewController(animated: true)
    }
    func getOffers(){
        
        db.collection("Offers").whereField("userID", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error while fetching profile\(error)")
                } else {
                    self.userOffers = []
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
                            let lat = data["lat"] as? Double ?? 0.0
                            let log = data["log"] as? Double ?? 0.0
                            
                            self.userOffers.append(Offer(title: offerTitle, description: offerDes, price: price, userID: userID, offerID: offerID, date: SharedInstanceManager.shared.dateFormatter.date(from: date) ?? Date(),lat: lat ,log: log, city: city, categoery: cat, image1: image1, image2: image2, image3: image3, image4: image4))
                        }
                        self.myColletionView.reloadData()
                        
                      
                    }
                }
            }
    }

}

//extension UserProfileViewController : UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userOffers.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = profileOffersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! profileTableViewCell
//        cell.offerImage.image = UIImage(data: userOffers[indexPath.row].image1)
//        cell.price.text! = userOffers[indexPath.row].price + " ريال سعودي"
//        cell.categoery.text = "#" + userOffers[indexPath.row].categoery
//        cell.title.text = userOffers[indexPath.row].title
//        cell.date.text = userOffers[indexPath.row].date.timeAgoDisplay()
//        cell.offers = userOffers[indexPath.row]
//        return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let details = OfferDetailsViewController()
//        details.offer = userOffers[indexPath.row]
//        self.navigationController?.pushViewController(details, animated: true)
//    }
//
//}
extension UserProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userOffers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myColletionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.image.image = UIImage(data: userOffers[indexPath.row].image1) ?? UIImage()
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = OfferDetailsViewController()
            details.offer = userOffers[indexPath.row]
            details.viewConrtollerDestination = true
            self.navigationController?.pushViewController(details, animated: true)
    }
}
