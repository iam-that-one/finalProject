//
//  VerefyingRequestViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 03/01/2022.
//

import UIKit
import MessageUI
import Firebase
class VerefyingRequestViewController: UIViewController ,MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    var imagePicker = UIImagePickerController()
    var user : [User]?
    var identityIsSelected = false
    var cerIsSelected = false
    lazy var identity : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "photo.fill")
        $0.tintColor = .lightGray
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    lazy var chooseId : UIButton = {
        $0.setTitle("ارفق صورة الهوية الوطنية بالضغط هنا", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(chooseIdBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var certificate : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "photo.fill")
        $0.tintColor = .lightGray
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    lazy var chooseCert : UIButton = {
        $0.setTitle("ارفق شهادة توثيقك من معروف بالضغط هنا", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(chooseCertBtnCLick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var sendReq : UIButton = {
        $0.setTitle("إرسال طلب التوثيق", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(sendRequestBtnCLick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var header : PaddingLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "طلب توثيق"
        $0.paddingTop = 20
        $00.textAlignment = .center
        $0.backgroundColor = UIColor.systemGray4
        return $0
    }(PaddingLabel())
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imagePicker.delegate = self
        [identity,certificate,chooseId,chooseCert,sendReq,header].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 120),
            
            identity.topAnchor.constraint(equalTo: header.bottomAnchor,constant: 20),
            identity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            identity.widthAnchor.constraint(equalToConstant: 300),
            identity.heightAnchor.constraint(equalToConstant: 150),
            
            chooseId.topAnchor.constraint(equalTo: identity.bottomAnchor,constant: 20),
            chooseId.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            certificate.topAnchor.constraint(equalTo: chooseId.bottomAnchor,constant: 20),
            certificate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            certificate.widthAnchor.constraint(equalToConstant: 300),
            certificate.heightAnchor.constraint(equalToConstant: 150),
            
            chooseCert.topAnchor.constraint(equalTo: certificate.bottomAnchor,constant: 20),
            chooseCert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sendReq.topAnchor.constraint(equalTo: chooseCert.bottomAnchor,constant: 20),
            sendReq.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            
        ])
        // Do any additional setup after loading the view.
    }
    @objc func chooseIdBtnClick(_ sender : UIButton){
        identityIsSelected = true
        cerIsSelected = false
           self.identity.isUserInteractionEnabled = true
           let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
               self.openCamera()
           }))
           
           alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
               self.openGallary()
           }))
           
           alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
           
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
    @objc func chooseCertBtnCLick(_ sender : UIButton){
        identityIsSelected = false
        cerIsSelected = true
           self.identity.isUserInteractionEnabled = true
           let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
               self.openCamera()
           }))
           
           alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
               self.openGallary()
           }))
           
           alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
           
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
    
    @objc func sendRequestBtnCLick(){
        sendMail(identity, certificate)
    }
    func sendMail(_ imageView1 : UIImageView,_ imageView2 : UIImageView) {
      if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self;
        mail.setCcRecipients(["ccsi-iuni@hotmail.com"])
          mail.setToRecipients(["ccsi-iuni@hotmail.com"])
          mail.setSubject("طلب توثيق")
          mail.delegate = self
          mail.setMessageBody("أنا \(user!.first!.name) ورقم جوالي \(user!.first!.phoneNumber) وبريدي الالكتروني \(String(describing: Auth.auth().currentUser!.email!)) ، أرغب في توثيق حسابي لديكم لتقديم الضمانات الكافية لعملائي.", isHTML: false)
          let imageData: NSData = imageView1.image!.pngData()! as NSData
          let imageData2: NSData = imageView2.image!.pngData()! as NSData
        mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "identity.png")
          mail.addAttachmentData(imageData2 as Data, mimeType: "image/png", fileName: "certificate.png")
          self.present(mail, animated: true, completion: nil)
      }
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        if identityIsSelected{
        self.identity.image = image
        }
        
        if cerIsSelected{
            self.certificate.image = image
        }
    }
    // ُTo dismiss Mail VC
    private func mailComposeController(controller: MFMailComposeViewController,
        didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
