//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 31/12/2021.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {
    let db = Firestore.firestore()
    var myOffers : [Offer] = []
    var myInfo : [User] = []
    let db1 = Firestore.firestore()
    var status = false
    lazy var darkmode : UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isOn = false
        $0.addTarget(self, action: #selector(changeModeBtnClicked), for: .valueChanged)
        return $0
    }(UISwitch())
    
    lazy var sendAuthReqBtn : UIButton = {
        $0.setTitle("طلب توثيق", for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(sendAuthReqBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    lazy var profileOffersTableView : UITableView = {
        $0.register(profileTableViewCell.self, forCellReuseIdentifier: "cell")
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
        $0.text = "حسابي"
        $0.backgroundColor = .systemTeal//UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        $0.clipsToBounds = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingTop = 40
        return $0
    }(PaddingLabel())
    
    lazy var container : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 7
        $0.backgroundColor = UIColor.systemGray4
        return $0
    }(UIView())
    
    lazy var profPic : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "person")
        
        return $0
    }(UIImageView())
    
    lazy var username : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "الاسم"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())
    lazy var signOut : UIButton = {
        $0.setTitle("تسجيل الخروج", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(signOutBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    lazy var email : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "الايميل"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())
    
    lazy var verfied : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .black
        return $0
    }(UIImageView())
    
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
        uiSettings()
        getProfile()
        getMyOffers()
        status = UserDefaults.standard.bool(forKey: "isDarkMode")
        darkmode.isOn = status
        if status{
            overrideUserInterfaceStyle = .dark
            
        }else{
            overrideUserInterfaceStyle = .light
        }
     
    }
    
    func uiSettings(){
        [email,username,profPic,verfied,darkmode].forEach{container.addSubview($0)}
        [profileOffersTableView,newLable,signOut,sendAuthReqBtn,container].forEach{view.addSubview($0)}

        NSLayoutConstraint.activate([
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            sendAuthReqBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            sendAuthReqBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            signOut.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            signOut.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            
            container.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 20),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.widthAnchor.constraint(equalToConstant: 350),
            container.heightAnchor.constraint(equalToConstant: 120),
            
            profPic.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -5),
            profPic.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            profPic.widthAnchor.constraint(equalToConstant: 100),
            profPic.heightAnchor.constraint(equalToConstant: 100),
            
            username.trailingAnchor.constraint(equalTo: profPic.leadingAnchor,constant: -10),
            username.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            
            email.topAnchor.constraint(equalTo: username.bottomAnchor,constant: 60),
            email.trailingAnchor.constraint(equalTo: profPic.leadingAnchor,constant: -10),
            
            verfied.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 10),
            verfied.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            verfied.widthAnchor.constraint(equalToConstant: 20),
            verfied.heightAnchor.constraint(equalToConstant: 20),
            
            darkmode.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            darkmode.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            profileOffersTableView.topAnchor.constraint(equalTo: container.bottomAnchor,constant: 5),
            profileOffersTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileOffersTableView.widthAnchor.constraint(equalToConstant: 350),
            profileOffersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            
            signOut.trailingAnchor.constraint(equalTo: newLable.trailingAnchor,constant: -20),
            signOut.centerYAnchor.constraint(equalTo: newLable.centerYAnchor,constant: 20)
        ])
    }
    @objc func sendAuthReqBtnClick(){
        let authVC = VerefyingRequestViewController()
        authVC.user = myInfo
        self.present(authVC, animated: true)
    }
    @objc func signOutBtnClick(){
        logOut()
    }
    func logOut(){
        do{
            try Auth.auth().signOut()
            let signIn = SignInViewController()
            
            signIn.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(signIn, animated: true)
        }catch{
            print(error)
        }
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
                            let phone = data["phoneNumnber"] as? String ?? ""
                            let firstName = data["firstName"] as! String
                            let isVerified = data["isVerified"] as? Bool ?? false
                            self.username.text = firstName
                            self.email.text = Auth.auth().currentUser!.email
                            let profilePic = data["image"] as! Data
                            if isVerified{
                                self.verfied.image = UIImage(systemName: "star.circle.fill") ?? UIImage()
                            }
                            print("dddddddddddddd", profilePic)
                            self.profPic.image = UIImage(data: profilePic)
                            self.myInfo.append(User(name: firstName, phoneNumber: phone, isVerified: isVerified))
                            if profilePic.count == 0{
                                self.profPic.image = UIImage(systemName: "person.circle.fill")
                            }
                            
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
                    self.myOffers = []
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
                            
                            self.myOffers.append(Offer(title: offerTitle, description: offerDes, price: price, userID: userID, offerID: offerID, date: SharedInstanceManager.shared.dateFormatter.date(from: date) ?? Date(),lat: lat ,log: log, city: city, categoery: cat, image1: image1, image2: image2, image3: image3, image4: image4))
                        }
                        self.profileOffersTableView.reloadData()
                        
                      
                    }
                }
            }
    }
    
    func deleteOffer(_ offer : Offer){
        db.collection("Offers").document(offer.offerID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    @objc func changeModeBtnClicked(){
        changeMode()
    }

    func changeMode(){
        status.toggle()
        UserDefaults.standard.set(status, forKey: "isDarkMode")
        if status{
            overrideUserInterfaceStyle = .dark
        }else{
            overrideUserInterfaceStyle = .light
        }
    }
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileOffersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! profileTableViewCell
        cell.offerImage.image = UIImage(data: myOffers[indexPath.row].image1)
        cell.price.text! = myOffers[indexPath.row].price + " ريال سعودي"
        cell.categoery.text = "#" + myOffers[indexPath.row].categoery
        cell.title.text = myOffers[indexPath.row].title
        cell.date.text = myOffers[indexPath.row].date.timeAgoDisplay()
        cell.offers = myOffers[indexPath.row]
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let details = OfferDetailsViewController()
        details.offer = myOffers[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
    }
}

extension ProfileViewController : OfferTableViewCellDelegate{
    func myPrfileTableViewEditButton(_ profileTableViewCel: profileTableViewCell, delete offer: Offer) {
        print("Edidting")
        let updateVC = UpdateViewController()
        updateVC.toBeUpdateOffer = offer
        updateVC.selectedCity = offer.city
        self.present(updateVC, animated: true, completion: nil)
    }
    
    func myPrfileTableViewCell(_ profileTableViewCel: profileTableViewCell, delete offer: Offer) {
        print(offer.offerID)
        let alert = UIAlertController(title: "تنبيه", message: "هل تود حذف هذا الإعلان", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: { (_) in
            self.deleteOffer(offer)
            
            self.getMyOffers()
        }))
        alert.addAction(UIAlertAction(title: "لا", style: .cancel, handler: { (_) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
