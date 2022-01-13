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
        $0.backgroundColor = .black
        $0.tintColor = .yellow
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var passwprd : UITextField = {
        $0.placeholder = "كلمة المرور"
        $0.text = "Aa123456789&"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var signInBtn : UIButton = {
        $0.setTitle("تسجيل الدخول", for: .normal)
        $0.setBackgroundImage(UIImage(named: "btn"), for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(signInBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var newLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "جديد؟"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var moveToSignUpBtn : UIButton = {
        $0.setTitle("قم بتسجيل حساب", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(moveToSignUpBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0.3, alpha: 1)
        setBackgroundImage(imageName: "w2")
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
        
            
            email.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 450),
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.widthAnchor.constraint(equalToConstant: 200),
            
            passwprd.topAnchor.constraint(equalTo: email.bottomAnchor,constant: 20),
            passwprd.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwprd.widthAnchor.constraint(equalToConstant: 200),
            
            
            signInBtn.topAnchor.constraint(equalTo: passwprd.bottomAnchor,constant: 30),
            signInBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInBtn.widthAnchor.constraint(equalToConstant: 200),
            signInBtn.heightAnchor.constraint(equalToConstant: 100),
            
            newLable.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -130),
            newLable.topAnchor.constraint(equalTo: signInBtn.bottomAnchor,constant: 20),
            
            moveToSignUpBtn.trailingAnchor.constraint(equalTo: newLable.leadingAnchor,constant: -5),
            moveToSignUpBtn.centerYAnchor.constraint(equalTo: newLable.centerYAnchor)
            
        ])
        
    }
    
    func setBackgroundImage(imageName: String){
        let background = UIImage(named: imageName)
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    @objc func signInBtnClick(sender :UIButton){
        signIn()
    }
    @objc func moveToSignUpBtnClick(){
        moveToSignUp()
    }
    func signIn(){
        let error = loginFieldsValidation()
        if error != nil{
            message = fieldsValidation()!
            alert = UIAlertController(title: "رسالة", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { _ in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }    else{
            Auth.auth().signIn(withEmail:email.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: passwprd.text!) { [self](result, error) in
                if error != nil{
                    self.message = error!.localizedDescription
                    self.message = self.fieldsValidation() ?? "هذا المستخدم غير موجود"
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
    
    func fieldsValidation() -> String?{
        if email.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwprd.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "الرجاء ملء جميع الحقول "
        }
        if emailValidation(email.text!.trimmingCharacters(in: .whitespaces)) == false{
            return "صيغة هذا البريد الإكتروني غير صالحة"
        }
        if passwordValidation(passwprd.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false{
            return "تأكد من أن كلمة المرور تتكون من ثمانية أحرف أو أكثر وأن تحتوي أحرف خاصة وأرقام"
        }
        return nil
    }
    func emailValidation(_ email : String) -> Bool{
        let checkedEmail = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return checkedEmail.evaluate(with: email.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    func passwordValidation(_ password : String) -> Bool{
        let checkedPassword = NSPredicate(format: "SELF MATCHES %@","^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-a\\d$@$#!%*?&]{8,}")
        return checkedPassword.evaluate(with: password.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    func loginFieldsValidation() -> String?{
        if email.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwprd.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "الرجاء ملء جميع الحقول "
        }
        if emailValidation(email.text!.trimmingCharacters(in: .whitespaces)) == false{
            return "صيغة هذا البريد الإكتروني غير صالحة"
        }
        return nil
    }
    
    // Move lofin view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -300
    }

    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
