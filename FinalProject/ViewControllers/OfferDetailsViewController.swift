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
    
    var isOnline = false
    var phoneNumber = ""
    let db = Firestore.firestore()
    lazy var stackView : UIStackView = {
        $0.axis = .horizontal
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
       // $0.layer.cornerRadius = 10
        $0.backgroundColor = .yellow
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
            $0.layer.cornerRadius = 5
        
        $0.layer.shadowRadius = 3.0
        $0.layer.shadowOpacity = 1.0

        return $0
    }(UILabel())
   
    lazy var offerDescription : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textAlignment = .right
        $0.layer.cornerRadius = 50
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
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
        //$0.backgroundColor = UIColor(red: 249, green: 195, blue: 34, alpha: 0)
        $0.backgroundColor = UIColor.systemGray5

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
        $0.backgroundColor = .black
        $0.tintColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(sendMessageBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var comments : UIButton = {
        $0.setTitle("التعليقات", for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(showCommentsBtnCkick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var phoneCall : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "phone.bubble.left.fill"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(phoneCallBtnClic), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    lazy var backToOfferViewBtn : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(backToOfferViewBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    override func viewDidLoad() {
        super.viewDidLoad()
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
        container.backgroundColor = UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        offerTitle.backgroundColor  = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        stackView.spacing = 10
        stackView.alignment = .fill // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        stackView.distribution = .fill // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
        
        [offerImage,image2,image3,image4].forEach{stackView.addArrangedSubview($0)}
        offerTitle.text = offer!.title
        offerImage.image = UIImage(data: offer!.image1) ?? UIImage()
        image2.setBackgroundImage(UIImage(data: offer!.image2) ?? UIImage(), for: .normal)
        image3.setBackgroundImage(UIImage(data: offer!.image3) ?? UIImage(), for: .normal)
        image4.setBackgroundImage(UIImage(data: offer!.image4) ?? UIImage(), for: .normal)
        
        offerDescription.text = offer!.description
        getProfile()
        [offerImage,offerTitle,offerDescription, stackView,container,backToOfferViewBtn].forEach{view.addSubview($0)}
        [profilePicture,username,appearance,sendMessage,phoneCall,dote,pin,comments].forEach{container.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            backToOfferViewBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            backToOfferViewBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            
            offerImage.topAnchor.constraint(equalTo: backToOfferViewBtn.bottomAnchor,constant: 20),
            offerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            offerImage.widthAnchor.constraint(equalToConstant: 370),
            offerImage.heightAnchor.constraint(equalToConstant: 300),
            
            offerTitle.widthAnchor.constraint(equalToConstant: 300),
            offerTitle.heightAnchor.constraint(equalToConstant: 150),
            offerTitle.centerXAnchor.constraint(equalTo: offerImage.centerXAnchor),
            offerTitle.topAnchor.constraint(equalTo: offerImage.bottomAnchor,constant: -80),
            
            offerDescription.topAnchor.constraint(equalTo: offerTitle.bottomAnchor,constant: 30),
            offerDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            offerDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            stackView.topAnchor.constraint(equalTo: offerDescription.bottomAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            image2.widthAnchor.constraint(equalToConstant: 100),
            image2.heightAnchor.constraint(equalToConstant: 100),
            image3.widthAnchor.constraint(equalToConstant: 100),
            image3.heightAnchor.constraint(equalToConstant: 100),
            image4.widthAnchor.constraint(equalToConstant: 100),
            image4.heightAnchor.constraint(equalToConstant: 100),
            
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.heightAnchor.constraint(equalToConstant: 150),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            profilePicture.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            profilePicture.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -20),
            profilePicture.widthAnchor.constraint(equalToConstant: 50),
            profilePicture.heightAnchor.constraint(equalToConstant: 50),
            
            username.firstBaselineAnchor.constraint(equalTo: profilePicture.firstBaselineAnchor),
            username.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            username.trailingAnchor.constraint(equalTo: profilePicture.leadingAnchor,constant: -10),
            
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
            phoneCall.widthAnchor.constraint(equalToConstant: 40),
            phoneCall.heightAnchor.constraint(equalToConstant: 40),
            
            pin.trailingAnchor.constraint(equalTo: sendMessage.leadingAnchor,constant: -10),
            pin.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -30),
            pin.widthAnchor.constraint(equalToConstant: 30),
            pin.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
    
    
    @objc func moveBtnClick(){
     let mapView = MapViewController()
        mapView.offer = offer
        mapView.modalPresentationStyle = .fullScreen
        self.present(mapView, animated: true, completion: nil)
    }
    
    
    @objc func showCommentsBtnCkick(){
        let commentView = CommentsViewController()
        commentView.offerID = offer!.offerID
        
        self.present(commentView, animated: true, completion: nil)
    }
    @objc func image2BtnClick(){
     
    }

    @objc func image3BtnClick(){
        
    }
    @objc func image4BtnClick(){
        
    }
    @objc func sendMessageBtnClick(){
        let chatView = ChatViewController()
        chatView.offerProvider = offer
        chatView.offerProviderId = offer!.userID
        chatView.initialMessage =  "حاب اسألك بخصوص عرضك بعنوان: " + offer!.title
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
    func isUserOnline(){
           let userRef = Database.database().reference(withPath: "online")
           userRef.observe(.value){ (snapshot) in
               if snapshot.hasChild(self.offer!.userID){
                   self.appearance.text = "متصل"
                   self.dote.tintColor = .green
               }
               else{
                   self.appearance.text = "غير متصل"
                   self.dote.tintColor = .red
               }
               
           }
       
       }
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
                            let isVerified = data["isVerified"] as! Bool
                            let profilePic = data["image"] as! Data
                            self.profilePicture.image = profilePic != Data() ? UIImage(data: profilePic) : UIImage(systemName: "person.fill")
                            let phoneNumber = data["phoneNumnber"] as? String ?? ""
                            self.phoneNumber = phoneNumber
                            self.offerProviderProfile = User(name: firstName,phoneNumber: phoneNumber, isVerified: isVerified)
                        }
                    }
                }
            }
    }
}


//class OfferDetailsViewController: UIViewController {
//    var offer : Offer? = nil
//    lazy var myColletionView : UICollectionView? = nil
//    lazy var stackView : UIStackView = {
//        $0.axis = .horizontal
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        return $0
//    }(UIStackView())
//
//
//    lazy var offerImage : UIImageView = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.image = UIImage(named: "pngwing.com")
//        return $0
//    }(UIImageView())
//
//    lazy var offerTitle : UILabel = {
//        $0.numberOfLines = 0
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.text = ""
//        $0.textAlignment = .center
//        $0.layer.cornerRadius = 10
//        $0.layer.masksToBounds = false
//        $0.backgroundColor = .yellow
//        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//        $0.layer.shadowRadius = 3.0
//        $0.layer.shadowOpacity = 1.0
//        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
//
//        return $0
//    }(UILabel())
//
//    lazy var offerDescription : UILabel = {
//        $0.numberOfLines = 0
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.text = ""
//        $0.textAlignment = .right
//        $0.layer.cornerRadius = 50
//        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//
//        return $0
//    }(UILabel())
//
//    lazy var image2 : UIButton = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.addTarget(self, action: #selector(image2BtnClick), for: .touchDown)
//        return $0
//    }(UIButton(type: .system))
//
//    lazy var image3 : UIButton = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.addTarget(self, action: #selector(image3BtnClick), for: .touchDown)
//        return $0
//    }(UIButton(type: .system))
//
//
//    lazy var image4 : UIButton = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.addTarget(self, action: #selector(image4BtnClick), for: .touchDown)
//        return $0
//    }(UIButton(type: .system))
//
//    lazy var container : UIView = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.backgroundColor = UIColor(red: 249, green: 195, blue: 34, alpha: 0)
//        return $0
//    }(UIView())
//
//    lazy var profilePicture : UIImageView = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.image = UIImage(systemName: "person.fill")
//        $0.tintColor = .black
//        return $0
//    }(UIImageView())
//
//    lazy var username : UILabel = {
//        $0.numberOfLines = 0
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.text = "عبدالله"
//        $0.textColor = .black
//        $0.textAlignment = .left
//        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//
//        return $0
//    }(UILabel())
//    lazy var appearance : UILabel = {
//        $0.numberOfLines = 0
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.text = "متصل"
//        $0.textColor = .black
//        $0.textAlignment = .left
//        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//
//        return $0
//    }(UILabel())
//
//    lazy var dote : UIImageView = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.image = UIImage(systemName: "circle.fill")
//        $0.tintColor = .green
//        return $0
//    }(UIImageView())
//
//    lazy var sendMessage: UIButton = {
//        $0.setTitle("ارسل رسالة للمعلن", for: .normal)
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.backgroundColor = .black
//        $0.tintColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
//        $0.layer.cornerRadius = 10
//        $0.addTarget(self, action: #selector(sendMessageBtnClick), for: .touchDown)
//        return $0
//    }(UIButton(type: .system))
//
//    lazy var phoneCall : UIButton = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.setBackgroundImage(UIImage(systemName: "phone.bubble.left.fill"), for: .normal)
//        $0.tintColor = .black
//        $0.addTarget(self, action: #selector(phoneCallBtnClic), for: .touchDown)
//        return $0
//    }(UIButton(type: .system))
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        uiSettings()
//          }
//    func uiSettings(){
//        view.backgroundColor = .white
//        container.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 0.50)
//        offerTitle.backgroundColor  = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
//        stackView.spacing = 10
//        stackView.alignment = .fill // .Leading .FirstBaseline .Center .Trailing .LastBaseline
//        stackView.distribution = .fill // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
//
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//               layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//               layout.itemSize = CGSize(width: 100, height: 100)
//
//        myColletionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        myColletionView!.backgroundColor = UIColor.white
//        myColletionView!.dataSource = self
//        myColletionView!.delegate = self
//        myColletionView!.backgroundColor = .darkGray
//        myColletionView!.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "coleectionViewCell")
//
//
//
//       // [offerImage,image2,image3].forEach{stackView.addArrangedSubview($0)}
//        offerTitle.text = offer!.title
//
//        offerDescription.text = offer!.description
//        offerImage.image = offer!.image
//        image2.setBackgroundImage(offer!.image2, for: .normal)
//        image3.setBackgroundImage(offer!.image3, for: .normal)
//        [offerImage,offerTitle,offerDescription,container,myColletionView!].forEach{view.addSubview($0)}
//        [profilePicture,username,appearance,sendMessage,phoneCall,dote].forEach{container.addSubview($0)}
//
//
//
//        myColletionView?.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            offerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
//            offerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            offerImage.widthAnchor.constraint(equalToConstant: 370),
//            offerImage.heightAnchor.constraint(equalToConstant: 300),
//
//            offerTitle.widthAnchor.constraint(equalToConstant: 300),
//            offerTitle.heightAnchor.constraint(equalToConstant: 150),
//            offerTitle.centerXAnchor.constraint(equalTo: offerImage.centerXAnchor),
//            offerTitle.topAnchor.constraint(equalTo: offerImage.bottomAnchor,constant: -80),
//
//            offerDescription.topAnchor.constraint(equalTo: offerTitle.bottomAnchor,constant: 30),
//            offerDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
//            offerDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
//
////            stackView.topAnchor.constraint(equalTo: offerDescription.bottomAnchor,constant: 20),
////            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
////            image2.widthAnchor.constraint(equalToConstant: 100),
////            image2.heightAnchor.constraint(equalToConstant: 100),
////            image3.widthAnchor.constraint(equalToConstant: 100),
////            image3.heightAnchor.constraint(equalToConstant: 100),
//            myColletionView!.topAnchor.constraint(equalTo: offerDescription.bottomAnchor,constant: 20),
//            myColletionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
//            myColletionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            myColletionView!.bottomAnchor.constraint(equalTo: container.topAnchor),
//            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//           container.topAnchor.constraint(equalTo: myColletionView!.bottomAnchor,constant: 10),
//            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//
//            profilePicture.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
//            profilePicture.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -20),
//            profilePicture.widthAnchor.constraint(equalToConstant: 50),
//            profilePicture.heightAnchor.constraint(equalToConstant: 50),
//
//            username.firstBaselineAnchor.constraint(equalTo: profilePicture.firstBaselineAnchor),
//            username.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
//            username.trailingAnchor.constraint(equalTo: profilePicture.leadingAnchor,constant: -10),
//
//            appearance.lastBaselineAnchor.constraint(equalTo: profilePicture.lastBaselineAnchor,constant:30),
//            appearance.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
//            appearance.trailingAnchor.constraint(equalTo: profilePicture.leadingAnchor,constant: -10),
//
//            dote.trailingAnchor.constraint(equalTo: appearance.leadingAnchor,constant: -10),
//            dote.centerYAnchor.constraint(equalTo: appearance.centerYAnchor),
//            sendMessage.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -20),
//            sendMessage.centerXAnchor.constraint(equalTo: container.centerXAnchor),
//            sendMessage.widthAnchor.constraint(equalToConstant: 200),
//            sendMessage.heightAnchor.constraint(equalToConstant: 40),
//
//            phoneCall.leadingAnchor.constraint(equalTo: sendMessage.trailingAnchor,constant: 10),
//            phoneCall.bottomAnchor.constraint(equalTo: sendMessage.bottomAnchor),
//            phoneCall.widthAnchor.constraint(equalToConstant: 40),
//            phoneCall.heightAnchor.constraint(equalToConstant: 40),
//
//        ])
//    }
//    @objc func image2BtnClick(){
//
//    }
//
//    @objc func image3BtnClick(){
//
//    }
//    @objc func image4BtnClick(){
//
//    }
//    @objc func sendMessageBtnClick(){
//        let chatView = ChatViewController()
//        self.navigationController?.pushViewController(chatView, animated: true)
//    }
//    @objc func phoneCallBtnClic(){
//
//    }
//}
//
//
//
//extension OfferDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = myColletionView!.dequeueReusableCell(withReuseIdentifier: "coleectionViewCell", for: indexPath) as! MyCollectionViewCell
//        cell.image.image = Offer.example[indexPath.row].image2
//        return cell
//    }
//
//
//}
