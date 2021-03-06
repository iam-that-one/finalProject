//
//  UpdateViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 03/01/2022.
//

import UIKit
import Firebase
import MapKit
class UpdateViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var lat = 0.0
    var log = 0.0
    var status = false
    var toBeUpdateOffer : Offer?
    var row : String?
    var toBeSavedImage1 : UIImage?
    var toBeSavedImage2 : UIImage?
    var toBeSavedImage3 : UIImage?
    var toBeSavedImage4 : UIImage?
    
    var toBeSavedImage1Stete : Bool?
    var toBeSavedImage2Stete : Bool?
    var toBeSavedImage3Stete : Bool?
    var toBeSavedImage4Stete : Bool?

 
    var imagePicker = UIImagePickerController()
    var selectedCity = "غير محدد"
    var selectedCat = ""
    let cities =  ["القنفذة", "الليث", "جدة", "مكة","الطائف", "رابغ","المجمعة", "القويعية", "الأفلاج", "الزلفي", "وادي الدواسر", "الدرعية", "الرياض","الخرج", "الدوادمي", "حوطة بني تميم",
                   "سكاكا","دومة الجندل","القريات","العقيق","القرى","قلوة","بلجرشي","المخواه","المندق","ثار","يدمة","خباش","حبونا","بدر الجنوب","شرورة","فرسان","القياس","العارضة","الحرث","بيش","العيدابي","الريث","ضمد","أحد المسارحة","الدائر","صبيا","صامطة","أبو عريش","رفحاء","طريف","عرعر","الغزالة","الشنان","بقعاء","أملج","حقل","الوجه","تيماء","ضباء","سراةعبيدة","بلقرن","المجاردة","رجال المع","تثليث","ظهران الجنوب","أحد رفيدة","خميس مشيط","النماص","محايل","بيشة","الخفجي","قرية العليا","الخرخير","بقيق","رأس تنورة","النعيرية","حفر الباطن","القطيف","الجبيل","الأحساء","الخبر","الشماسية","الأسياح","البدائع","رياض الخبراء","عيون الجواء","البكيرية","بريدة","عنيزة","المذنب","الرس","الحناكية","المهد","خيبر","بدر","المدينة","ينبع","العلا","الخرمة", "خليص", "الكامل", "رنية", "تربة", "الجمجوم","رماح", "ثادق", "حريملاء", "المزاحمية", "الحريق", "الغاط", "السليل", "عفيف", "ضرماء"
                       ]
    var categories = ["أجهزة","سيارات","خدمات", "أخرى","عقارات","أزياء"]
    
   
    lazy var pageTitle : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "تحديث"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.backgroundColor = .systemTeal//UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingTop = 20
        
        return $0
    }(PaddingLabel())
    lazy var offerTitle : UITextField = {
        $0.placeholder = "عنوان المنتج"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
      lazy var offerDes : UITextView = {
          $0.backgroundColor = UIColor.systemGray4
          $0.clipsToBounds = true
          $0.layer.cornerRadius = 5
          $0.layer.borderColor = .init(gray: 0.90, alpha: 1)
          $0.layer.borderWidth = 1
          $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextView())
    
    lazy var price : UITextField = {
        $0.placeholder = "السعر"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var segment : UISegmentedControl = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(segmentClicked), for: .valueChanged)
        $0.backgroundColor = .systemTeal//UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        return $0
    }(UISegmentedControl(items: categories))
  
    lazy var picker: UIPickerView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        return $0
    }(UIPickerView())
    
    // // // //
    
    lazy var image1 : UIButton = {
        $0.tintColor = UIColor.systemGray4
        $0.setBackgroundImage(UIImage(systemName: "photo.fill"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(image1BtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var image2 : UIButton = {
        $0.tintColor = UIColor.systemGray4
        $0.setBackgroundImage(UIImage(systemName: "photo.fill"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(image2BtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    
    lazy var image3 : UIButton = {
        $0.tintColor = UIColor.systemGray4
        $0.setBackgroundImage(UIImage(systemName: "photo.fill"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(image3BtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    
    lazy var image4 : UIButton = {
        $0.tintColor = UIColor.systemGray4
        $0.setBackgroundImage(UIImage(systemName: "photo.fill"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(image4BtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var stackView : UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 5
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    lazy var postOfferBtn : UIButton = {
        $0.setTitle("تحديث", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector( updateOfferBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    override func viewWillAppear(_ animated: Bool) {
        status = UserDefaults.standard.bool(forKey: "isDarkMode")
        
        if status{
            overrideUserInterfaceStyle = .dark
            
        }else{
            overrideUserInterfaceStyle = .light
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // // // // // Initiate update fields// // // // //
        
        view.backgroundColor = .white
        toBeSavedImage1 = UIImage(data: toBeUpdateOffer!.image1)
         toBeSavedImage2 = UIImage(data: toBeUpdateOffer!.image2)
         toBeSavedImage3 = UIImage(data: toBeUpdateOffer!.image3)
         toBeSavedImage4 = UIImage(data: toBeUpdateOffer!.image4)
        
        image1.setBackgroundImage(toBeSavedImage1, for: .normal)
        image2.setBackgroundImage(toBeSavedImage2, for: .normal)
        image3.setBackgroundImage(toBeSavedImage3, for: .normal)
        image4.setBackgroundImage(toBeSavedImage4, for: .normal)
        
        offerTitle.text = toBeUpdateOffer!.title
        offerDes.text = toBeUpdateOffer!.description
        price.text = toBeUpdateOffer!.price
        
        // // // // // // // // // //
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        [pageTitle,offerTitle,offerDes,segment,price,picker,stackView,postOfferBtn].forEach{view.addSubview($0)}
        [image1,image2,image3,image4].forEach{stackView.addArrangedSubview($0)}
        
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.topAnchor),
            pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitle.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            pageTitle.heightAnchor.constraint(equalToConstant: 120),
            
            offerTitle.topAnchor.constraint(equalTo: pageTitle.bottomAnchor,constant: 20),
            offerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            offerTitle.widthAnchor.constraint(equalToConstant: 300),
            
            offerDes.topAnchor.constraint(equalTo: offerTitle.bottomAnchor,constant: 20),
            offerDes.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            offerDes.widthAnchor.constraint(equalToConstant: 300),
            offerDes.heightAnchor.constraint(equalToConstant: 100),
            
            price.topAnchor.constraint(equalTo: offerDes.bottomAnchor,constant: 20),
            price.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            price.widthAnchor.constraint(equalToConstant: 300),
            
            segment.topAnchor.constraint(equalTo: price.bottomAnchor,constant: 20),
            segment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segment.widthAnchor.constraint(equalToConstant: 300),
            segment.widthAnchor.constraint(equalToConstant: 370),
            segment.heightAnchor.constraint(equalToConstant: 80),
            
            picker.topAnchor.constraint(equalTo: segment.bottomAnchor,constant: 20),
//             picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -20),
            picker.widthAnchor.constraint(equalToConstant: 190),
            picker.heightAnchor.constraint(equalToConstant: 100),
            
           
            stackView.topAnchor.constraint(equalTo: picker.bottomAnchor,constant: 20),
            //stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            //stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalToConstant: 350),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image1.widthAnchor.constraint(equalToConstant: 85),
            image1.heightAnchor.constraint(equalToConstant: 85),
            image2.widthAnchor.constraint(equalToConstant: 85),
            image2.heightAnchor.constraint(equalToConstant: 85),
            image3.widthAnchor.constraint(equalToConstant: 85),
            image3.heightAnchor.constraint(equalToConstant: 85),
            image4.widthAnchor.constraint(equalToConstant: 85),
            image4.heightAnchor.constraint(equalToConstant: 85),
            
            postOfferBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20),
            postOfferBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postOfferBtn.widthAnchor.constraint(equalToConstant: 200),
            postOfferBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func segmentClicked(){
        if segment.selectedSegmentIndex == 0{
            selectedCat = categories[0]
            print(selectedCat)
        }else if segment.selectedSegmentIndex == 1{
            selectedCat = categories[1]
            print(selectedCat)
        }else if segment.selectedSegmentIndex == 2{
            selectedCat = categories[2]
            print(selectedCat)
        }else if segment.selectedSegmentIndex == 3{
            selectedCat = categories[3]
            print(selectedCat)
        }else if segment.selectedSegmentIndex == 4{
            selectedCat = categories[4]
            print(selectedCat)
        }else if segment.selectedSegmentIndex == 5{
                selectedCat = categories[5]
                print(selectedCat)
        }else{
            selectedCat = categories[6]
            print(selectedCat)
        }
    }
    @objc func  updateOfferBtnClick(){
        updateOffer()
    }
   
    func updateOffer(){
        let db = Firestore.firestore()
      
        let newData = ["cate" : selectedCat, "image1": self.uploadImage(self.toBeSavedImage1 ?? UIImage()),"city":self.selectedCity,"image2": self.uploadImage(self.toBeSavedImage2 ?? UIImage()),"image3": self.uploadImage(self.toBeSavedImage3 ?? UIImage()),"image4": self.uploadImage(self.toBeSavedImage4 ?? UIImage()),"offerDes" : offerDes.text!,"offerTitle" : offerTitle.text!,"price" : price.text!] as [String:Any]
                        db.collection("Offers").document(toBeUpdateOffer!.offerID).setData(newData , merge: true)
            
        self.dismiss(animated: true, completion: nil)
    }
   
              
    @objc func image1BtnClick(_ sender : UIButton){
        toBeSavedImage1Stete = false
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .photoLibrary
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
        
    }
    @objc func image2BtnClick(){
        toBeSavedImage2Stete = false
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .photoLibrary
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }

    @objc func image3BtnClick(){
        toBeSavedImage3Stete = false
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .photoLibrary
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    @objc func image4BtnClick(){
        toBeSavedImage4Stete = false
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .photoLibrary
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
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
                let alert  = UIAlertController(title: "تحذير", message: "الوصول إلى الكاميرا غير متاح", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        func openGallary()
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    
  

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.lat = locValue.latitude
        self.log = locValue.longitude
    }

}

extension UpdateViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.selectedCity = cities[row]
        return self.selectedCity
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCity = cities[row]
        print(selectedCity)
    }
}

extension UpdateViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    // Image Picker controller
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        if toBeSavedImage1Stete != nil{
        image1.setBackgroundImage(image, for: .normal)
            toBeSavedImage1 = image
            toBeSavedImage1Stete = nil
        }
        if toBeSavedImage2Stete != nil{
        image2.setBackgroundImage(image, for: .normal)
            toBeSavedImage2 = image
            toBeSavedImage2Stete = nil
        }
        if toBeSavedImage3Stete != nil{
        image3.setBackgroundImage(image, for: .normal)
            toBeSavedImage3 = image
            toBeSavedImage3Stete = nil
        }
        if toBeSavedImage4Stete != nil{
        image4.setBackgroundImage(image, for: .normal)
            toBeSavedImage4 = image
            toBeSavedImage4Stete = nil
        }
    }
    
    func uploadImage(_ image : UIImage) -> Data{
          guard let imageData = image.jpegData(compressionQuality: 0.1) else {return Data()}
          return imageData
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
