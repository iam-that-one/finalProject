//
//  PrefViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 23/05/2022.
//

import UIKit
import Firebase

class PrefViewController: UIViewController {
    let userRef = Database.database().reference(withPath: "online")
    var user : [User]?
    let prefs : [PresModel] = [PresModel(lable: "الوضع الليلي", logo: "moon.fill"),PresModel(lable: "طلب توثيق", logo: "star.circle.fill"),PresModel(lable: "تسجيل الخروج", logo: "signpost.right.fill")]
    
    lazy var backToProfileViewBtn : UIButton = {
        $0.tintColor = .black
        $0.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(backToProfileViewBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var newLable : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "إعدادات الحساب"
        $0.textColor = DefaultStyle.Colors.label
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        $0.clipsToBounds = true
        $0.paddingTop = 20
        $0.textAlignment = .center
        $0.backgroundColor = DefaultStyle.Colors.header
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(PaddingLabel())
    lazy var preTableView : UITableView = {
        $0.register(PrefViewTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(newLable)
        view.addSubview(preTableView)
        view.addSubview(backToProfileViewBtn)
        
        view.backgroundColor = DefaultStyle.Colors.mainView
        NSLayoutConstraint.activate([
            
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.widthAnchor.constraint(equalToConstant: view.bounds.width),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            backToProfileViewBtn.centerYAnchor.constraint(equalTo: newLable.centerYAnchor),
            backToProfileViewBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            backToProfileViewBtn.heightAnchor.constraint(equalToConstant: 40),
            backToProfileViewBtn.widthAnchor.constraint(equalToConstant: 30),
            
            
            preTableView.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 10),
            preTableView.widthAnchor.constraint(equalToConstant: 380),
            preTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            preTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
            
        ])
        // Do any add  itional setup after loading the view.
    }
    
    @objc func backToProfileViewBtnClick(){
        self.navigationController?.popViewController(animated: true)
      
    }
    
 
}
extension PrefViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        prefs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = preTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PrefViewTableViewCell
        cell.lable.text = prefs[indexPath.row].lable
        cell.logo.image = UIImage(systemName: prefs[indexPath.row].logo) ?? UIImage()
        if status && indexPath.row == 0{
            cell.contentView.backgroundColor = .green
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            status = UserDefaults.standard.bool(forKey: "isDarkMode")
            status.toggle()
            UserDefaults.standard.set(status, forKey: "isDarkMode")

           exit(0)
            
        }
        if indexPath.row == 1{
        let authVC = VerefyingRequestViewController()
        authVC.user = user
        self.present(authVC, animated: true)
        }
        
        if indexPath.row == 2{
            logOut()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func logOut(){
        if Auth.auth().currentUser != nil{
           let userRef = Database.database().reference(withPath: "online")
            let user = Auth.auth().currentUser!
           let currentUserRef = userRef.child(user.uid)
           currentUserRef.removeValue()
        }
        do{
            
            try Auth.auth().signOut()
            let signIn = SignInViewController()
            
            signIn.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(signIn, animated: true)
            
            
        }catch{
            print(error)
        }
        self.dismiss(animated: true, completion: nil)
    }
}


struct PresModel{
    let lable : String
    let logo : String
}
