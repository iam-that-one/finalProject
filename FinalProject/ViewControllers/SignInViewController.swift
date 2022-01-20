//
//  SignInViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 03/01/2022.
//

import UIKit
import Firebase
class SignInViewController: UIViewController {
    var message = ""
    let userRef = Database.database().reference(withPath: "online")

    var status = false
    var alert = UIAlertController()
    lazy var logo : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "capsule.portrait.righthalf.filled")
        $0.tintColor = UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        return $0
    }(UIImageView())
    
    lazy var email : UITextField = {
        $0.placeholder = "ايميلك لو سمحت"
        $0.text = "n@nn.com"
        $0.backgroundColor = .darkGray
        $0.textColor = UIColor.lightGray
        $0.tintColor = UIColor.lightGray
        $0.attributedPlaceholder = NSAttributedString(
            string: "الاسم الأول",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
        $0.tintColor = .black
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var passwprd : UITextField = {
        $0.placeholder = "كلمة المرور"
        $0.text = "Aa123456789&"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .darkGray
        $0.textColor = UIColor.lightGray
        $0.tintColor = UIColor.lightGray
        $0.attributedPlaceholder = NSAttributedString(
            string: "الاسم الأول",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var signInBtn : UIButton = {
        $0.setTitle("تسجيل الدخول", for: .normal)
        $0.setBackgroundImage(UIImage(named: "grayBtn"), for: .normal)
        $0.tintColor = .yellow
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(signInBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var newLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "جديد؟"
        $0.textColor = .darkGray
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var moveToSignUpBtn : UIButton = {
        $0.setTitle("قم بتسجيل حساب", for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(moveToSignUpBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
            status = UserDefaults.standard.bool(forKey: "isDarkMode")
            
            if status{
                overrideUserInterfaceStyle = .dark
                
            }else{
                overrideUserInterfaceStyle = .light
            }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0.3, alpha: 1)
        SharedInstanceManager.shared.setBackgroundImage(imageName: "w3", view: view)
        uiSettings()
    }
    
    
    func uiSettings(){
        [signInBtn,newLable,moveToSignUpBtn,passwprd,email].forEach{view.addSubview($0)}
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NSLayoutConstraint.activate([
        
            
            email.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 200),
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.widthAnchor.constraint(equalToConstant: 200),
            
            passwprd.topAnchor.constraint(equalTo: email.bottomAnchor,constant: 20),
            passwprd.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwprd.widthAnchor.constraint(equalToConstant: 200),
            
            
            signInBtn.topAnchor.constraint(equalTo: passwprd.bottomAnchor,constant: 30),
            signInBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInBtn.widthAnchor.constraint(equalToConstant: 200),
            signInBtn.heightAnchor.constraint(equalToConstant: 50),
            
            newLable.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -130),
            newLable.topAnchor.constraint(equalTo: signInBtn.bottomAnchor,constant: 20),
            
            moveToSignUpBtn.trailingAnchor.constraint(equalTo: newLable.leadingAnchor,constant: -5),
            moveToSignUpBtn.centerYAnchor.constraint(equalTo: newLable.centerYAnchor)
            
        ])
        
    }
    

    @objc func signInBtnClick(sender :UIButton){
        signIn()
    }
    @objc func moveToSignUpBtnClick(){
        moveToSignUp()
    }
    func signIn(){
        let error = SharedInstanceManager.shared.loginFieldsValidation(email, passwprd)
        if error != nil{
            SharedInstanceManager.shared.playAudioAsset("error")
            message = SharedInstanceManager.shared.fieldsValidation(email, passwprd)!
            alert = UIAlertController(title: "رسالة", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { _ in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }    else{
            Auth.auth().signIn(withEmail:email.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: passwprd.text!) { [self](result, error) in
                if error != nil{
                    SharedInstanceManager.shared.playAudioAsset("error")
                    self.message = error!.localizedDescription
                    self.message = SharedInstanceManager.shared.fieldsValidation(email, passwprd) ?? "هذا المستخدم غير موجود"
                    self.alert = UIAlertController(title: "رسالة", message: message, preferredStyle: .alert)
                    self.alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { _ in
                        
                    }))
                    self.present(self.alert, animated: true, completion: nil)
                    return
                }
                else{
                    if let user = Auth.auth().currentUser{
                        let currentUserRef = self.userRef.child(user.uid)
                        currentUserRef.setValue(user.email)
                        currentUserRef.onDisconnectRemoveValue()
                        let dashboard = DashboardTabBarController()
                      //  self.present(dashboard, animated: true, completion: nil)
                        self.navigationController?.pushViewController(dashboard, animated: true)
                    }
                }
            }
        }
    }
    
    func moveToSignUp(){
        let sigunUp = SignUpViewController()
        self.navigationController?.pushViewController(sigunUp, animated: true)
    }
    
    // Move lofin view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
        
        SharedInstanceManager.shared.keyboardWillShow(view, -100)
    }

    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillHide(view)
    }
    @objc func dismissKeyboard() {
        SharedInstanceManager.shared.dismissKeyboard(view)
    }
  
}
