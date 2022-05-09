//
//  SignUpViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 03/01/2022.
//
import Foundation

import UIKit
import Firebase
class SignUpViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
   // var imagePicker = UIImagePickerController()
    let userRef = Database.database().reference(withPath: "online")
    var toBeUploaded = UIImage()
    var message = ""
    var alert = UIAlertController()
    var status = false
    lazy var profilePic : UIButton = {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .darkGray
        $0.setBackgroundImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        $0.addTarget(self, action: #selector(selectImage), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var phoneNumber : UITextField = {
        $0.backgroundColor = .darkGray
        $0.textColor = UIColor.lightGray
        $0.tintColor = UIColor.lightGray
        $0.attributedPlaceholder = NSAttributedString(
            string: "رقم الجوال",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.keyboardType = .phonePad
        return $0
    }(UITextField())
    
        lazy var email : UITextField = {
            $0.backgroundColor = .darkGray
            $0.textColor = UIColor.lightGray
            $0.tintColor = UIColor.lightGray
            $0.attributedPlaceholder = NSAttributedString(
                string: "الايميل",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                )
        $0.borderStyle = .roundedRect
       // $0.transform = $0.transform.rotated(by: 45)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var password : UITextField = {
        $0.backgroundColor = .darkGray
        $0.textColor = UIColor.lightGray
        $0.tintColor = UIColor.lightGray
        $0.attributedPlaceholder = NSAttributedString(
            string:"كلمة المرور",
            attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray]
            )
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var firstName : UITextField = {
        $0.backgroundColor = .darkGray
        $0.textColor = UIColor.lightGray
        $0.tintColor = UIColor.lightGray
        $0.attributedPlaceholder = NSAttributedString(
            string: "الاسم الأول",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var lastName : UITextField = {
        $0.backgroundColor = .darkGray
        $0.textColor = UIColor.lightGray
        $0.tintColor = UIColor.lightGray
        $0.attributedPlaceholder = NSAttributedString(
            string: "الاسم الأخير",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var verficationCode : UITextField = {
        $0.placeholder = "تدخل رقم التحقق هنا"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        return $0
    }(UITextField())
    
    
    lazy var signUpBtn : UIButton = {
        $0.setTitle("تسجيل حساب", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .yellow
        $0.setBackgroundImage(UIImage(named: "grayBtn"), for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.addTarget(self, action: #selector(signUpBtnClick), for: .touchDown)
      //  $0.transform = $0.transform.rotated(by: 90)
        return $0
    }(UIButton(type: .system))
    
    lazy var newLable : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("تسجيل الدخول", for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(moveToSignIn), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var signUpBtnVer : UIButton = {
        $0.setTitle("تحقق", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .black
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.addTarget(self, action: #selector(verfiyBtnClick), for: .touchDown)
        $0.isHidden = true
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
        SharedInstanceManager.shared.imagePicker.delegate = self
        view.backgroundColor = .white
        SharedInstanceManager.shared.setBackgroundImage(imageName: "wallpaperflare.com_wallpaper", view: view)

        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        [profilePic,signUpBtn,signUpBtnVer,phoneNumber,verficationCode,firstName,lastName,email,password,newLable].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            profilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            profilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePic.widthAnchor.constraint(equalToConstant: 150),
            profilePic.heightAnchor.constraint(equalToConstant: 150),
            
            phoneNumber.topAnchor.constraint(equalTo: profilePic.bottomAnchor,constant: 50),
            phoneNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            phoneNumber.widthAnchor.constraint(equalToConstant: 200),
                                               
            firstName.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor,constant: 20),
            firstName.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            firstName.widthAnchor.constraint(equalToConstant: 200),
            
            lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor,constant: 20),
            lastName.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            lastName.widthAnchor.constraint(equalToConstant: 200),
            
            email.topAnchor.constraint(equalTo: lastName.bottomAnchor,constant: 20),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            email.widthAnchor.constraint(equalToConstant: 200),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor,constant: 20),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            password.widthAnchor.constraint(equalToConstant: 200),
            
            
            signUpBtn.topAnchor.constraint(equalTo: password.bottomAnchor,constant: 20),
            signUpBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpBtn.widthAnchor.constraint(equalToConstant: 200),
            signUpBtn.heightAnchor.constraint(equalToConstant: 50),
            verficationCode.topAnchor.constraint(equalTo: signUpBtn.bottomAnchor,constant: 20),
            verficationCode.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verficationCode.widthAnchor.constraint(equalToConstant: 200),
            
            signUpBtnVer.topAnchor.constraint(equalTo: verficationCode.bottomAnchor,constant: 20),
            signUpBtnVer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpBtnVer.widthAnchor.constraint(equalToConstant: 200),
            signUpBtnVer.heightAnchor.constraint(equalToConstant: 50),
            
            newLable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            newLable.centerXAnchor.constraint(equalTo: signUpBtn.centerXAnchor)
        ])
      
    }
    @objc func moveToSignIn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func selectImage(_ sender : UIButton){
        self.profilePic.setTitleColor(UIColor.white, for: .normal)
           self.profilePic.isUserInteractionEnabled = true
           
           let alert = UIAlertController(title: "اختر صورة", message: nil, preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "الكاميرا", style: .default, handler: { _ in
               SharedInstanceManager.shared.openCamera(viewController: self)
           }))
           
           alert.addAction(UIAlertAction(title: "ألبوم الصور", style: .default, handler: { _ in
               SharedInstanceManager.shared.openGallary(viewController: self)
           }))
           
           alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
           
           /*If you want work actionsheet on ipad
           then you have to use popoverPresentationController to present the actionsheet,
           otherwise app will crash on iPad */
           switch UIDevice.current.userInterfaceIdiom {
           case .pad:
               alert.popoverPresentationController?.sourceView = sender
               alert.popoverPresentationController?.sourceRect = sender.bounds
               alert.popoverPresentationController?.permittedArrowDirections = .up
           default:
               break
           }
           
           self.present(alert, animated: true, completion: nil)
       }

    @objc func signUpBtnClick(){
        signUp()
    }
    
    
    func signUp(){
        let error = SharedInstanceManager.shared.loginFieldsValidation(email, password)
        if error != nil{
            SharedInstanceManager.shared.playAudioAsset("error")
            message =  SharedInstanceManager.shared.fieldsValidation(email, password)!
            alert = UIAlertController(title: "رسالة", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { _ in
                
            }))
            self.present(alert, animated: true, completion: nil)
          
        }
        else {
            message = ""
            self.message = SharedInstanceManager.shared.fieldsValidation(self.email, self.password) ?? ""
            if message != "" {
            self.alert = UIAlertController(title: "رسالة", message: self.message, preferredStyle: .alert)
            self.alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { _ in
                SharedInstanceManager.shared.playAudioAsset("error")
            }))
            self.present(self.alert, animated: true, completion: nil)
            return
            }
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber.text!, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print("------------------------------")
                print(error)
                SharedInstanceManager.shared.playAudioAsset("error")
                self.message = "تأكد من صيفة رقم الهاتف المدخل"
                self.alert = UIAlertController(title: "رسالة", message: self.message, preferredStyle: .alert)
                self.alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { _ in
                    
                }))
                self.present(self.alert, animated: true, completion: nil)
                return
            }
            else {
                // Sign in using the verificationID and the code sent to the user
                // ...
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                print("------------------------------")
                print(verificationID!)
                self.verficationCode.isHidden = false
                self.signUpBtnVer.isHidden = false
            }
        }
        }
    }
    
   @objc func verfiyBtnClick(){
        verfiy()
    }
    func verfiy(){
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
         let credential = PhoneAuthProvider.provider().credential(
             withVerificationID: verificationID ?? "",
             verificationCode: verficationCode.text!)
             Auth.auth().signIn(with: credential) { success, error in
                 if error == nil {
                 let user = Auth.auth().currentUser
                 user?.delete { error in
                     if let error = error {
                         print(error)
                      } else {
                         print("User account has been deleted")
                     }
                 }
                 Auth.auth().createUser(withEmail: self.email.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: self.password.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (result, error) in
                     if error != nil{
                      //   message = error!.localizedDescription
                     }
                     else{
                         let db = Firestore.firestore()
                         db.collection("offers_users").addDocument(data: ["firstName" : self.firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines),"lastName":self.lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines),"email":self.email.text!.trimmingCharacters(in: .whitespacesAndNewlines),"uid":result!.user.uid,"image": SharedInstanceManager.shared.uploadImage((self.toBeUploaded)),"phoneNumnber": self.phoneNumber.text!, "isVerified":false] as [String: Any])

                             if let user = Auth.auth().currentUser{
                                 let currentUserRef = self.userRef.child(user.uid)
                                 print("ididididididididididididididididididi")
                                 print(user.uid)
                                 currentUserRef.setValue(user.email)
                                 currentUserRef.onDisconnectRemoveValue()
                             }
                         let dashboard = DashboardTabBarController()
                         dashboard.modalPresentationStyle = .fullScreen
                         self.navigationController?.pushViewController(dashboard, animated: true)
                     }
                 }
             }
             else{
                 print(error!)
             }
         }
    }

    // Move signUp view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillShow(view, -100)
    }

    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillHide(view)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.profilePic.setBackgroundImage(image, for: .normal)
        self.toBeUploaded = image
    }

   
}
