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
    var imagePicker = UIImagePickerController()
    let userRef = Database.database().reference(withPath: "online")
    var toBeUploaded = UIImage()
    var message = ""
    var alert = UIAlertController()
    var status = false
    lazy var profilePic : UIButton = {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .black
        $0.setBackgroundImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        $0.addTarget(self, action: #selector(selectImage), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var phoneNumber : UITextField = {
        $0.placeholder = "دخل رقم جوالك"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.keyboardType = .phonePad
        $0.backgroundColor = UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        return $0
    }(UITextField())
    
        lazy var email : UITextField = {
        $0.placeholder = "الايميل"
        $0.borderStyle = .roundedRect
       // $0.transform = $0.transform.rotated(by: 45)
            $0.backgroundColor = UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var password : UITextField = {
        $0.placeholder = "كلمة المرور"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var firstName : UITextField = {
        $0.placeholder = "الاسم الأول"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var lastName : UITextField = {
        $0.placeholder = "الاسم الأخير"
        $0.backgroundColor = UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var verficationCode : UITextField = {
        $0.placeholder = "تدخل رقم التحقق هنا"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        return $0
    }(UITextField())
    
    
    lazy var signUpBtn : UIButton = {
        $0.setTitle("تسجيل حساب", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .black
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.addTarget(self, action: #selector(signUpBtnClick), for: .touchDown)
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
        imagePicker.delegate = self
        view.backgroundColor = .white
        setBackgroundImage(imageName: "w2")

        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        [profilePic,signUpBtn,signUpBtnVer,phoneNumber,verficationCode,firstName,lastName,email,password,newLable].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            profilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 100),
            profilePic.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            profilePic.widthAnchor.constraint(equalToConstant: 100),
            profilePic.heightAnchor.constraint(equalToConstant: 100),
            
            phoneNumber.topAnchor.constraint(equalTo: profilePic.bottomAnchor,constant: 100),
            phoneNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumber.widthAnchor.constraint(equalToConstant: 200),
                                               
            firstName.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor,constant: 20),
            firstName.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            firstName.widthAnchor.constraint(equalToConstant: 200),
            
            lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor,constant: 20),
            lastName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastName.widthAnchor.constraint(equalToConstant: 200),
            
            email.topAnchor.constraint(equalTo: lastName.bottomAnchor,constant: 20),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            email.widthAnchor.constraint(equalToConstant: 200),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor,constant: 20),
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.widthAnchor.constraint(equalToConstant: 200),
            
            
            signUpBtn.topAnchor.constraint(equalTo: password.bottomAnchor,constant: 20),
            signUpBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpBtn.widthAnchor.constraint(equalToConstant: 350),
            signUpBtn.widthAnchor.constraint(equalToConstant: 300),
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
           
           let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
               self.openCamera()
           }))
           
           alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
               self.openGallary()
           }))
           
           alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
           
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
    
    func openCamera()
        {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = true
                
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        func openGallary()
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }


    @objc func signUpBtnClick(){
        signUp()
    }
    
    
    func signUp(){
        let error = loginFieldsValidation()
        if error != nil{
            message = fieldsValidation()!
            alert = UIAlertController(title: "رسالة", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { _ in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber.text!, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print("------------------------------")
                print(error)
                return
            }
            else{
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
                         db.collection("offers_users").addDocument(data: ["firstName" : self.firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines),"lastName":self.lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines),"email":self.email.text!.trimmingCharacters(in: .whitespacesAndNewlines),"uid":result!.user.uid,"image": self.uploadImage((self.toBeUploaded)),"phoneNumnber": self.phoneNumber.text!, "isVerified":false] as [String: Any])

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
    // Move signUp view 300 points upward
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.profilePic.setBackgroundImage(image, for: .normal)
        self.toBeUploaded = image
    }
    func uploadImage(_ image : UIImage) -> Data{
          guard let imageData = image.jpegData(compressionQuality: 0.1) else {return Data()}
          return imageData
      }
    func fieldsValidation() -> String?{
        if email.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "الرجاء ملء جميع الحقول "
        }
        if emailValidation(email.text!.trimmingCharacters(in: .whitespaces)) == false{
            return "صيغة هذا البريد الإكتروني غير صالحة"
        }
        if passwordValidation(password.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false{
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
        if email.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "الرجاء ملء جميع الحقول "
        }
        if emailValidation(email.text!.trimmingCharacters(in: .whitespaces)) == false{
            return "صيغة هذا البريد الإكتروني غير صالحة"
        }
        return nil
    }
    
}
