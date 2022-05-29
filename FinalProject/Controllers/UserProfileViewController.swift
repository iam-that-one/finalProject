//
//  UserProfileViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 19/05/2022.
//

import UIKit
import Firebase
import SwiftUI
class UserProfileViewController: UIViewController {

    lazy var sendRate : UIButton = {
        $0.setTitle("أرسل تقييمك ⭐️", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = DefaultStyle.self.Colors.header
        $0.tintColor = .black
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowColor = CGColor.init(gray: 0.60, alpha: 1)
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.addTarget(self, action: #selector(sendingRateBtnClicked), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    lazy var ratingView : RatingView = {
        return $0
    }(RatingView(frame: .zero, starNumber: 1))
    
 
    var visirors = 0
    var userId = ""
    var userName = ""
    var numberOfOffers = 0
    var profilePic = Data()
    var userOffers : [Offer] = []
    var totalStars = 0
    let db = Firestore.firestore()
    
    lazy var vStackView1 : UIStackView = {
        $0.axis = .vertical
        $0.spacing = 9
       // $0.distribution = .fillEqually
        $0.alignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    lazy var vStackView2 : UIStackView = {
        $0.axis = .vertical
        $0.spacing = 9
     //   $0.distribution = .fillEqually
        $0.alignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    lazy var vStackView3 : UIStackView = {
        $0.axis = .vertical
        $0.spacing = 9
      //  $0.distribution = .fillEqually
        $0.alignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    lazy var hStackView : UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    

    
    lazy var bio : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "أهلاً بكم في حسابي. أتمنى أن تعجبكم عروضي."
        $0.textColor = DefaultStyle.self.Colors.label
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    lazy var container : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = DefaultStyle.self.Colors.mainView
        $0.layer.borderColor = DefaultStyle.self.Colors.borderColor
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
        $0.backgroundColor = DefaultStyle.self.Colors.mainView
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
        $0.backgroundColor = DefaultStyle.self.Colors.header//UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
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
    
    lazy var nubmerOfOffersLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "العروض"
        $0.textColor = DefaultStyle.self.Colors.label
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var nubmerOfVisitorsLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "الزيارات"
        $0.textColor = DefaultStyle.self.Colors.label
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var nubmerOfPointsLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "النقاط"
        $0.textColor = DefaultStyle.self.Colors.label
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var nubmerOfOffers : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = DefaultStyle.self.Colors.label
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var nubmerOfVisitors : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = DefaultStyle.self.Colors.label
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var nubmerOfPoints : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "0"
        $0.textColor = DefaultStyle.self.Colors.label
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    
    // // // // // // // // // //
    
    lazy var stackView : UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    lazy var star1 : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = DefaultStyle.self.Colors.label
        return $0
    }(UIButton(type: .system))
    
    lazy var star2 : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = DefaultStyle.self.Colors.label
        return $0
    }(UIButton(type: .system))
    
    lazy var star3 : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = DefaultStyle.self.Colors.label
        return $0
    }(UIButton(type: .system))
    
    lazy var star4 : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = DefaultStyle.self.Colors.label
        return $0
    }(UIButton(type: .system))
    
    lazy var star5 : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = DefaultStyle.self.Colors.label
        return $0
    }(UIButton(type: .system))
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSettings()
        getOffers()
        nubmerOfOffers.text = "\(numberOfOffers)"
        newLable.text = "أنا \(userName) حياك الله في حسابي"
        profileImage.image = UIImage(data: profilePic) 
        layout.estimatedItemSize = .init(width: 120, height: 110)
        print("corner",profileImage.frame.size.height / 2)
        profileImage.layer.cornerRadius = 40//profileImage.frame.size.height / 2
        profileImage.layer.masksToBounds = true
        //nubmerOfPoints.text = "\(UserDefaults.standard.value(forKey: "rate1") ?? 0)"
        getAllRates()
        view.backgroundColor = DefaultStyle.self.Colors.mainView
        bio.text = " أنا \(userName) أهلاً بكم في حسابي. أتمنى لكم تصفحاً ممتعاً. يرجى مراسلتي على الخاص عند  اهتمامك بأحد عروضي."
        getRating()
        [star1,star2,star3,star4,star4,star5].forEach{stackView.addArrangedSubview($0)}
    }
    
    func uiSettings(){
        view.backgroundColor = .white
        [vStackView1,vStackView2,vStackView3].reversed().forEach{hStackView.addArrangedSubview($0)}
        [nubmerOfOffersLable,nubmerOfOffers].forEach{vStackView1.addArrangedSubview($0)}
        [nubmerOfVisitorsLable,nubmerOfVisitors].forEach{vStackView2.addArrangedSubview($0)}
        [nubmerOfPointsLable,nubmerOfPoints].forEach{vStackView3.addArrangedSubview($0)}
        [profileImage,bio,hStackView,stackView].forEach{container.addSubview($0)}
        [newLable,backToOfferViewBtn,myColletionView,container,ratingView,sendRate].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            stackView.widthAnchor.constraint(equalToConstant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 25),
            backToOfferViewBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            backToOfferViewBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            backToOfferViewBtn.heightAnchor.constraint(equalToConstant: 40),
            backToOfferViewBtn.widthAnchor.constraint(equalToConstant: 30),
            
            ratingView.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 10),
            ratingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ratingView.widthAnchor.constraint(equalToConstant: 300),
            ratingView.heightAnchor.constraint(equalToConstant: 40),
            
            sendRate.topAnchor.constraint(equalTo: ratingView.bottomAnchor,constant: 5),
            sendRate.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor),
            sendRate.widthAnchor.constraint(equalToConstant: 200),
            sendRate.heightAnchor.constraint(equalToConstant: 35),
            
            container.topAnchor.constraint(equalTo: sendRate.bottomAnchor,constant: 30),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.heightAnchor.constraint(equalToConstant: 200),
            container.widthAnchor.constraint(equalToConstant: 350),
            
        
            
            profileImage.topAnchor.constraint(equalTo: container.topAnchor,constant: 20),
            profileImage.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -5),
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            
            hStackView.topAnchor.constraint(equalTo: container.topAnchor,constant: 40),
            hStackView.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: -100),
            hStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 20),
            
            
            bio.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            bio.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -20),
            bio.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 20),
            bio.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -10),
            
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -8),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 8),
            
            myColletionView.topAnchor.constraint(equalTo: container.bottomAnchor,constant: 20),
            //myColletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            //myColletionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            myColletionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myColletionView.widthAnchor.constraint(equalToConstant: 350),
            myColletionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 120)
            ])
    }
    @objc func sendingRateBtnClicked(){
        ratingView.uploadRat(uid: self.userId)
        nubmerOfPoints.text = "\(UserDefaults.standard.value(forKey: "rate1") ?? 0)"
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
                            self.nubmerOfOffers.text = "\(self.userOffers.count)"
                        }
                        self.myColletionView.reloadData()
                      
                    }
                }
            }
    }

    func getRating(){
        db.collection("Rating").whereField("user", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { querySnapshot, error in
            if let error = error{
                print(error)
            }else{
                if let snapShots = querySnapshot?.documents{
                    for doc in snapShots{
                        let data = doc.data()
                        let ratedUser = data["ratedUserId"] as? String
                        
                        if ratedUser == self.userId{
                            let stars = data["stars"] as? Int ?? 0
                            self.ratingView.starNumber = stars
                            
                            if stars == 1{
                                self.ratingView.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            }
                            
                            if stars == 2{
                                self.ratingView.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                                self.ratingView.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            }
                            
                            if stars == 3{
                                self.ratingView.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                                self.ratingView.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                                self.ratingView.star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                               print(stars)
                            }
                            
                            if stars == 4{
                                self.ratingView.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                                self.ratingView.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                                self.ratingView.star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                                self.ratingView.star4.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                              
                            }
                            
                            if stars == 5{
                                self.ratingView.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                                self.ratingView.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                                self.ratingView.star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                                self.ratingView.star4.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                                self.ratingView.star5.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            }
                            if stars > 0{
                                self.ratingView.star1.isEnabled = false
                                self.ratingView.star2.isEnabled = false
                                self.ratingView.star3.isEnabled = false
                                self.ratingView.star4.isEnabled = false
                                self.ratingView.star5.isEnabled = false
                                self.ratingView.star1.tintColor = .systemGray4
                                self.ratingView.star2.tintColor = .systemGray4
                                self.ratingView.star3.tintColor = .systemGray4
                                self.ratingView.star4.tintColor = .systemGray4
                                self.ratingView.star5.tintColor = .systemGray4
                                self.sendRate.setTitle("لقد قمت بالتقييم فعلاً. شكراً ⭐️", for: .normal)
                                self.sendRate.isEnabled = false
                            }
                        }
                    }
                }
            }
        }
    }
    func getAllRates(){
        db.collection("Rating").whereField("ratedUserId", isEqualTo: userId).addSnapshotListener { QuerySnapshot, error in
            if let error = error{
                print(error)
            }else{
                if let snapShots = QuerySnapshot?.documents{
                    self.totalStars = 0
                    for doc in snapShots{
                        let data = doc.data()
                        
                        let stars =  data["stars"] as? Int ?? 0
                        self.totalStars = self.totalStars + stars
                        print(self.totalStars)
                        self.nubmerOfPoints.text = "\(self.totalStars)"
                        
                        if stars > 3 && stars <= 50{
                            self.star1.setBackgroundImage(UIImage(systemName: "star.leadinghalf.filled"), for: .normal)
                            self.star2.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star3.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star4.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                        }else if stars > 50 && stars <= 100{
                            self.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star2.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star3.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star4.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                        }else if stars > 100 && stars <= 150{
                            self.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star2.setBackgroundImage(UIImage(systemName: "star.leadinghalf.filled"), for: .normal)
                            self.star3.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star4.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                        }else if stars > 150 && stars <= 200{
                            self.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star3.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star4.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                        }else if stars > 200 && stars <= 250{
                            self.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star3.setBackgroundImage(UIImage(systemName: "star.leadinghalf.filled"), for: .normal)
                            self.star4.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                        }else if stars > 250 && stars <= 300{
                            self.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star4.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                            self.star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                        }else if stars > 300 && stars <= 350{
                            self.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star4.setBackgroundImage(UIImage(systemName: "star.leadinghalf.filled"), for: .normal)
                            self.star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                        }else if stars > 350 && stars <= 400{
                            self.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star4.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                        }
                        else if stars > 400 && stars <= 450{
                            self.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star4.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star5.setBackgroundImage(UIImage(systemName: "star.leadinghalf.filled"), for: .normal)
                        }else if stars > 450 {
                            self.star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star4.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                            self.star5.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                        }
                    }
                    
                }
                
            }
        }
    }
}
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
