//
//  RatingView.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 28/05/2022.
//

import Foundation
import UIKit
import Firebase

class RatingView : UIView{
    let db = Firestore.firestore()
    var starNumber : Int
    lazy var stackView : UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 9
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    lazy var star1 : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(star1BtnClicked), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var star2 : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(star2BtnClicked), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var star3 : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(star3BtnClicked), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var star4 : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(star4BtnClicked), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var star5 : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(star5BtnClicked), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    
    var id = ""
    init(frame: CGRect, starNumber : Int) {
        self.starNumber = starNumber
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        viewSetting()
        print(self.starNumber)
    }
    func viewSetting(){
        [star1,star2,star3,star4,star4,star5].forEach{stackView.addArrangedSubview($0)}
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func uploadRat(uid : String){
         print("rating for the id ",uid, "was uploaded")
        UserDefaults.standard.set(starNumber, forKey: "rate1")
         
         db.collection("Rating").addDocument(data: ["ratedUserId" : uid,"user": Auth.auth().currentUser!.uid, "stars":starNumber]) { error in
             print(error?.localizedDescription as Any)
         }
    }
    @objc func star1BtnClicked(){
        
        // Rate
        star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        
        // Un rate
        star2.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        star3.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        star4.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        
        starNumber = 1
        print(starNumber)
    }
    @objc func star2BtnClicked(){
        
        // Rate
        star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        
        
        // Un rate
        
        star3.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        star4.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        
        starNumber = 2
        print(starNumber)
    }
    @objc func star3BtnClicked(){
        
        // Rate
        
        star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        
        // Un rate
        
       
        star4.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        
        starNumber = 3
        print(starNumber)
    }
    @objc func star4BtnClicked(){
        
        // rate
        
        star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        star4.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        
        // Un rate
        star5.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        
        starNumber = 4
        print(starNumber)
    }
    @objc func star5BtnClicked(){
        star1.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        star2.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        star3.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        star4.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        star5.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        
        starNumber = 5
        print(starNumber)
    }
    
    func starsFilling(){
         
    }
}
