//
//  Extensions.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 01/01/2022.
//

import UIKit
import Foundation
import Firebase
import AVFAudio
class SharedInstanceManager{
    static var shared : SharedInstanceManager = SharedInstanceManager()
    
    var audioPlayer: AVAudioPlayer!
    var imagePicker = UIImagePickerController()
    
    
    var dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm E, d MMM y"
          formatter.dateStyle = .medium
          formatter.timeStyle = .medium
          return formatter
      }()
    
    func keyboardWillShow(_ view : UIView, _ constant : CGFloat){
       view.frame.origin.y = constant
    }
    
    func keyboardWillHide(_ view : UIView){
        view.frame.origin.y = 0
    }
    
    func dismissKeyboard(_ view : UIView){
        view.endEditing(true)
    }
    
    func uploadImage(_ image : UIImage) -> Data{
          guard let imageData = image.jpegData(compressionQuality: 0.1) else {return Data()}
          return imageData
      }
    
    func fieldsValidation(_ email : UITextField, _ password : UITextField ) -> String?{
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
    func loginFieldsValidation(_ email : UITextField, _ password : UITextField) -> String?{
        if email.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "الرجاء ملء جميع الحقول "
        }
        if emailValidation(email.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false{
            return "صيغة هذا البريد الإكتروني غير صالحة"
        }
        return nil
    }
    
    func openCamera(viewController : UIViewController){
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = true
                viewController.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "تحذير", message: "الوصول إلى الكاميرا غير متاح", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                viewController.present(alert, animated: true, completion: nil)
            }
        }

        func openGallary(viewController : UIViewController)
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            viewController.present(imagePicker, animated: true, completion: nil)
        }
    
    func setBackgroundImage(imageName: String, view : UIView){
        let background = UIImage(named: imageName)
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
    
    
    func playAudioAsset(_ assetName : String) {
       guard let audioData = NSDataAsset(name: assetName)?.data else {
          fatalError("Unable to find asset \(assetName)")
       }

       do {
          audioPlayer = try AVAudioPlayer(data: audioData)
          audioPlayer.play()
       } catch {
          fatalError(error.localizedDescription)
     }
    }
}
