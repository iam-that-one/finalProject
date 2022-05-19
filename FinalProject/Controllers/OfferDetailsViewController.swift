//
//  OfferDetailsViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 01/01/2022.
//

import UIKit
import SwiftUI
import Firebase
class OfferDetailsViewController: UIViewController {
    var offer : Offer? = nil
    var offerProviderProfile : User? = nil
    var viewControllerSourceIndicator = false
    var status = false
    var isOnline = false
    var phoneNumber = ""
    var userName = ""
    var viewConrtollerDestination = false
    var toBeSendProfilePic = Data()
    var bookBtnToggl = false
    let db = Firestore.firestore()
    
    lazy var newLable : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "تفاصيل أكثر"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        $0.clipsToBounds = true
        $0.backgroundColor = .systemTeal//UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.paddingTop = 50
        $0.paddingBottom = 10
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            
      //  $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(PaddingLabel())
    
    lazy var verfied : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .black
        return $0
    }(UIImageView())
    lazy var book : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(bookBtnClick), for: .touchDown)
        $0.tintColor = .systemTeal
        return $0
    }(UIButton(type: .system))
    
    lazy var stackView : UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    
    lazy var offerImage : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "pngwing.com")
        return $0
    }(UIImageView())
    
    lazy var offerTitle : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = .systemTeal
        $0.alpha = 0.90
        $0.layer.borderWidth = 3
        $0.layer.borderColor = .init(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
            $0.layer.cornerRadius = 5
        
        $0.layer.shadowRadius = 3.0
        $0.layer.shadowOpacity = 1.0

        return $0
    }(UILabel())
   
    lazy var offerDescription : UITextView = {
      //  $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textAlignment = .right
        $0.layer.cornerRadius = 10
        $0.isEditable = false
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        return $0
    }(UITextView())
    
    lazy var image2 : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(image2BtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var image3 : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(image3BtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    
    lazy var image4 : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(image4BtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var container : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.borderColor = CGColor.init(gray: 0.90, alpha: 1)
        $0.layer.borderWidth = 3
        return $0
    }(UIView())
    
    lazy var profilePicture : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "person.fill")
        $0.layer.borderColor = CGColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.layer.borderWidth = 3
        $0.backgroundColor = .lightGray
        $0.tintColor = .black
        return $0
    }(UIImageView())
    
    lazy var username : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "عبدالله"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    lazy var appearance : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "غير متصل"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        
        return $0
    }(UILabel())
    
    lazy var dote : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "circle.fill")
        $0.tintColor = UIColor.init(red: 34/255, green: 139/355, blue: 34/255, alpha: 1)
        $0.layer.borderColor = CGColor.init(red: 34/255, green: 139/255, blue: 34/255, alpha: 1)
        $0.layer.borderWidth = 10
        $0.layer.cornerRadius = 40
        return $0
    }(UIImageView())
    
    lazy var pin : UIButton = {
        $0.setBackgroundImage(UIImage(named: "pin"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(moveBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    lazy var sendMessage: UIButton = {
        $0.setTitle("ارسل رسالة للمعلن", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemTeal
        $0.tintColor = .white//UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(sendMessageBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var comments : UIButton = {
        $0.setTitle("التعليقات 📨", for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(showCommentsBtnCkick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var phoneCall : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "phone.fill"), for: .normal)
        $0.tintColor = .systemTeal
        $0.transform = $0.transform.rotated(by: -90)
        $0.addTarget(self, action: #selector(phoneCallBtnClic), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    lazy var backToOfferViewBtn : UIButton = {
        $0.tintColor = .black
        $0.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(backToOfferViewBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var moveToUserProfileViewBtn : UIButton = {
        $0.tintColor = .black
        $0.setBackgroundImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(UserProfileBtnClicked), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewConrtollerDestination{
            moveToUserProfileViewBtn.isHidden = true
        }
        isUserOnline()
        if isOnline == true{
            appearance.text = "متصل"
            dote.tintColor = .green
        }else{
            appearance.text = "غير متصل"
            dote.tintColor = .red
        }
        uiSettings()
          }
    func uiSettings(){
        view.backgroundColor = .white
        container.backgroundColor = .white
        
        stackView.spacing = 10
        stackView.alignment = .fill // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        stackView.distribution = .fillEqually // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
            
        [offerImage,image2,image3,image4].forEach{stackView.addArrangedSubview($0)}
        offerTitle.text = offer!.title
        offerImage.image = UIImage(data: offer!.image1) ?? UIImage()
        image2.setBackgroundImage(UIImage(data: offer!.image2) ?? UIImage(), for: .normal)
        image3.setBackgroundImage(UIImage(data: offer!.image3) ?? UIImage(), for: .normal)
        image4.setBackgroundImage(UIImage(data: offer!.image4) ?? UIImage(), for: .normal)
        
        offerDescription.text = offer!.description
        getProfile()
        getBookmarks()
        [newLable,offerImage,offerTitle,offerDescription, stackView,container,backToOfferViewBtn,moveToUserProfileViewBtn].forEach{view.addSubview($0)}
        [profilePicture,username,appearance,sendMessage,phoneCall,dote,pin,comments,verfied,book].forEach{container.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            
            backToOfferViewBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            backToOfferViewBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            
            
            
            offerImage.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 20),
            offerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            offerImage.widthAnchor.constraint(equalToConstant: 370),
            offerImage.heightAnchor.constraint(equalToConstant: 300),
            
            offerTitle.widthAnchor.constraint(equalToConstant: 300),
            offerTitle.heightAnchor.constraint(equalToConstant: 50),
            offerTitle.centerXAnchor.constraint(equalTo: offerImage.centerXAnchor),
            offerTitle.topAnchor.constraint(equalTo: offerImage.bottomAnchor,constant: -25),
            
            offerDescription.topAnchor.constraint(equalTo: offerTitle.bottomAnchor,constant: 10),
            offerDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            offerDescription.widthAnchor.constraint(equalToConstant: 300),
            offerDescription.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: offerDescription.bottomAnchor,constant: 10),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 350),
            stackView.heightAnchor.constraint(equalToConstant: 140),
            
            image2.widthAnchor.constraint(equalToConstant: 100),
            image2.heightAnchor.constraint(equalToConstant: 100),
            image3.widthAnchor.constraint(equalToConstant: 100),
            image3.heightAnchor.constraint(equalToConstant: 100),
            image4.widthAnchor.constraint(equalToConstant: 100),
            image4.heightAnchor.constraint(equalToConstant: 100),
            
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.widthAnchor.constraint(equalToConstant: 350),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            profilePicture.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            profilePicture.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -20),
            profilePicture.widthAnchor.constraint(equalToConstant: 50),
            profilePicture.heightAnchor.constraint(equalToConstant: 50),
            
            username.firstBaselineAnchor.constraint(equalTo: profilePicture.firstBaselineAnchor),
            username.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            username.trailingAnchor.constraint(equalTo: profilePicture.leadingAnchor,constant: -10),
            
            verfied.trailingAnchor.constraint(equalTo: username.leadingAnchor,constant: -10),
            verfied.centerYAnchor.constraint(equalTo: username.centerYAnchor),
            
            comments.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 10),
            comments.topAnchor.constraint(equalTo: container.topAnchor),
            
            appearance.lastBaselineAnchor.constraint(equalTo: profilePicture.lastBaselineAnchor,constant:30),
            appearance.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            appearance.trailingAnchor.constraint(equalTo: profilePicture.leadingAnchor,constant: -10),
            
            dote.trailingAnchor.constraint(equalTo: appearance.leadingAnchor,constant: -10),
            dote.centerYAnchor.constraint(equalTo: appearance.centerYAnchor),
            sendMessage.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -20),
            sendMessage.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            sendMessage.widthAnchor.constraint(equalToConstant: 200),
            sendMessage.heightAnchor.constraint(equalToConstant: 40),
            
            phoneCall.leadingAnchor.constraint(equalTo: sendMessage.trailingAnchor,constant: 10),
            phoneCall.bottomAnchor.constraint(equalTo: sendMessage.bottomAnchor),
            phoneCall.widthAnchor.constraint(equalToConstant: 30),
            phoneCall.heightAnchor.constraint(equalToConstant: 30),
            
            pin.trailingAnchor.constraint(equalTo: sendMessage.leadingAnchor,constant: -10),
            pin.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -30),
            pin.widthAnchor.constraint(equalToConstant: 30),
            pin.heightAnchor.constraint(equalToConstant: 30),
            
            book.trailingAnchor.constraint(equalTo: pin.leadingAnchor,constant: -10),
            book.centerYAnchor.constraint(equalTo: pin.centerYAnchor),
            book.widthAnchor.constraint(equalToConstant: 30),
            book.heightAnchor.constraint(equalToConstant: 30),
            
            backToOfferViewBtn.heightAnchor.constraint(equalToConstant: 40),
            backToOfferViewBtn.widthAnchor.constraint(equalToConstant: 30),
            
            
            moveToUserProfileViewBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            moveToUserProfileViewBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            moveToUserProfileViewBtn.heightAnchor.constraint(equalToConstant: 40),
            moveToUserProfileViewBtn.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
  
    @objc func moveBtnClick(){
     let mapView = MapViewController()
        mapView.offer = offer
        mapView.modalPresentationStyle = .fullScreen
        self.present(mapView, animated: true, completion: nil)
    }
    
    @objc func bookBtnClick(){
        makeItBooked()
    }
    func makeItBooked(){
       bookBtnToggl.toggle()
   
        if bookBtnToggl{
            book.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            db.collection("Bookmarks").document(offer!.offerID).setData(["id" : Auth.auth().currentUser!.uid, "offerID" : offer!.offerID])
        }else{
            book.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            db.collection("Bookmarks").document(offer!.offerID).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    @objc func showCommentsBtnCkick(){
        let commentView = CommentsViewController()
        commentView.offerID = offer!.offerID
        self.present(commentView, animated: true, completion: nil)
        
    }
    
    // To make image bigger for the user
    @objc func image2BtnClick(){
        let vc = MaketItViewController()
        vc.image = offer!.image2
        self.present(vc, animated: true, completion: nil)
    }

    @objc func image3BtnClick(){
        let vc = MaketItViewController()
        vc.image = offer!.image3
        self.present(vc, animated: true, completion: nil)
    }
    @objc func image4BtnClick(){
        let vc = MaketItViewController()
        vc.image = offer!.image4
        self.present(vc, animated: true, completion: nil)
    }
    
    // TO move to chat view controller
    @objc func sendMessageBtnClick(){
        isUserOnline()
        let chatView = ChatViewController()
        chatView.offerProvider = offer
        chatView.offerProviderId = offer!.userID
        chatView.initialMessage =  "حاب اسألك بخصوص عرضك بعنوان: " + offer!.title
        chatView.isOnline = isOnline
        chatView.offerProviderPofile = offerProviderProfile
        
        if viewControllerSourceIndicator == false{
        self.navigationController?.pushViewController(chatView, animated: true)
        }else{
            self.present(chatView, animated: true, completion: nil)
        }
    }
    
    @objc func phoneCallBtnClic(){
        call()
    }
    func call(){
        if let url = URL(string: "tel://\(self.phoneNumber)"),
        UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    }
    @objc func backToOfferViewBtnClick(){
        if viewControllerSourceIndicator == false{
        self.navigationController?.popViewController(animated: true)
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func UserProfileBtnClicked(){
        let userProfile = UserProfileViewController()
        userProfile.userId = offer!.userID
        userProfile.userName = userName
        userProfile.profilePic = toBeSendProfilePic
        navigationController?.pushViewController(userProfile, animated: true)
    }
    
    // To check whether the use of is online or not
    
    func isUserOnline(){
           let userRef = Database.database().reference(withPath: "online")
           userRef.observe(.value){ (snapshot) in
               if snapshot.hasChild(self.offer!.userID){
                   self.appearance.text = "متصل"
                   self.dote.tintColor = .green
                   self.isOnline = true
               }
               else{
                   self.appearance.text = "غير متصل"
                   self.dote.tintColor = .red
                   self.isOnline = false
               }
               
           }
       
       }
    
    // Get bookmarked offers
    
    func getBookmarks(){
        db.collection("Bookmarks").addSnapshotListener { querySnapshot, error in
            if let error = error{
                print(error)
            }else{
                for doc in querySnapshot!.documents{
                    let data = doc.data()
                    let id = data["id"] as? String ?? ""
                    let offerID = data["offerID"] as? String ?? ""
                    
                    if id == Auth.auth().currentUser!.uid && offerID == self.offer!.offerID{
                        self.book.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                        break
                    }
                }
            }
        }
    }
    
    // Get user profile
    func getProfile(){
        db.collection("offers_users").whereField("uid", isEqualTo: offer!.userID)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error while fetching profile\(error)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let firstName = data["firstName"] as! String
                            self.username.text = firstName
                            self.userName = firstName
                            let isVerified = data["isVerified"] as? Bool ?? false
                            let profilePic = data["image"] as! Data
                            self.toBeSendProfilePic = profilePic
                            self.profilePicture.image = profilePic != Data() ? UIImage(data: profilePic) : UIImage(systemName: "person.fill")
                            let phoneNumber = data["phoneNumnber"] as? String ?? ""
                            self.phoneNumber = phoneNumber
                            self.offerProviderProfile = User(name: firstName,phoneNumber: phoneNumber, isVerified: isVerified)
                            if isVerified{
                                self.verfied.image = UIImage(systemName: "star.circle.fill") ?? UIImage()
                            }
                        }
                    }
                }
            }
    }
}

