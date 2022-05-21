//
//  AddOfferViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 31/12/2021.
//

import UIKit
import MapKit
import AVFAudio
import Firebase
class AddOfferViewController: UIViewController, CLLocationManagerDelegate{
    var audioPlayer: AVAudioPlayer!
    let locationManager = CLLocationManager()
    var lat = 0.0
    var log = 0.0
    var isUpdating = false
    var status = false
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
        $0.text = "إضافة إعلان جديد"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        $0.clipsToBounds = true
        $0.backgroundColor = .systemTeal//UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingTop = 20
        return $0
    }(PaddingLabel())
    
    lazy var cityLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "اختر اسم المدينة"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var imagesLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "اختر صورك الأربعة للمنتج * "
        $0.textColor = .red
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    
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
          $0.textColor = UIColor.lightGray
          $0.text = "وصف المنتج"
          $0.delegate = self
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
        $0.tintColor = UIColor.darkGray
        $0.setBackgroundImage(UIImage(systemName: "photo.fill"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(image1BtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var image2 : UIButton = {
        $0.tintColor = UIColor.darkGray
        $0.setBackgroundImage(UIImage(systemName: "photo.fill"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(image2BtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    
    lazy var image3 : UIButton = {
        $0.tintColor = UIColor.darkGray
        $0.setBackgroundImage(UIImage(systemName: "photo.fill"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(image3BtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    
    lazy var image4 : UIButton = {
        $0.tintColor = UIColor.darkGray
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
    
  
    // // // //
    
    lazy var postOfferBtn : UIButton = {
        $0.setTitle("أنشر", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(named: "grayBtn"), for: .normal)
        $0.tintColor = .yellow
        $0.addTarget(self, action: #selector(postOfferBtnClick), for: .touchDown)
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
        let db =  Firestore.firestore()
        let newData = ["image" : SharedInstanceManager.shared.uploadImage(UIImage(named: "1168742") ?? UIImage())]
         db.collection("offers_users").whereField("uid", isEqualTo:"QEZ0nuX4tNX1pX1kTHuKfmkKtOm1")
            .getDocuments { (result, error) in
                            if error == nil{
                                for document in result!.documents{
                                    //document.setValue("1", forKey: "isolationDate")
                                    db.collection("offers_users").document(document.documentID).setData(newData , merge: true)
                                }
                            }
                        }
        locationSettings()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        uiSettings()
       
    }
    func locationSettings(){
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    func uiSettings(){
        
         [pageTitle,offerTitle,offerDes,segment,price,picker,stackView,postOfferBtn,cityLable,imagesLable].forEach{view.addSubview($0)}
         [image1,image2,image3,image4].forEach{stackView.addArrangedSubview($0)}
        stackView.alignment = .fill // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        stackView.distribution = .fillEqually // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
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
             segment.widthAnchor.constraint(equalToConstant: 370),
             segment.heightAnchor.constraint(equalToConstant: 80),
             
             
             picker.topAnchor.constraint(equalTo: segment.bottomAnchor,constant: 20),
//             picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             picker.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -20),
             picker.widthAnchor.constraint(equalToConstant: 190),
             picker.heightAnchor.constraint(equalToConstant: 100),
             
             cityLable.leadingAnchor.constraint(equalTo: picker.trailingAnchor,constant: 10),
             cityLable.centerYAnchor.constraint(equalTo: picker.centerYAnchor),
             
             stackView.topAnchor.constraint(equalTo: picker.bottomAnchor,constant: 20),
             //stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             //stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             stackView.widthAnchor.constraint(equalToConstant: 300),
             stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             
            // imagesLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             imagesLable.centerXAnchor.constraint(equalTo: image4.centerXAnchor,constant: -50),
             imagesLable.bottomAnchor.constraint(equalTo: stackView.topAnchor),
             
             image1.widthAnchor.constraint(equalToConstant: 50),
             image1.heightAnchor.constraint(equalToConstant: 60),
             image2.widthAnchor.constraint(equalToConstant: 50),
             image2.heightAnchor.constraint(equalToConstant: 60),
             image3.widthAnchor.constraint(equalToConstant: 50),
             image3.heightAnchor.constraint(equalToConstant: 60),
             image4.widthAnchor.constraint(equalToConstant: 50),
             image4.heightAnchor.constraint(equalToConstant: 60),
             
             postOfferBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20),
             postOfferBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             postOfferBtn.widthAnchor.constraint(equalToConstant: 100),
             postOfferBtn.heightAnchor.constraint(equalToConstant: 50)
         ])
    }
    @objc func segmentClicked(){
        getSelectedSegment()
    }
    func getSelectedSegment(){
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
    @objc func postOfferBtnClick(){
        addOffer()
    }
   
    func addOffer(){
        if toBeSavedImage1 == nil || toBeSavedImage2 == nil || toBeSavedImage3 == nil || toBeSavedImage4 == nil || offerTitle.text == "" || offerDes.text == "" || price.text == "" || selectedCat == ""{
            let alert = UIAlertController(title: "تنبيه!", message: "يجب ملء جميع الحقول بما في ذلك الصور", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { (_) in
               // return
            }))
            self.present(alert, animated: true, completion: nil)
            SharedInstanceManager.shared.playAudioAsset("error")
            return
        }
        SharedInstanceManager.shared.playAudioAsset("warning")
        let alert = UIAlertController(title: "إقرار", message: "أتعههد أنا صاحب هذا الإعلان بدفع عمولة بقيمة 1% من سعر المنتج المعلن عنه في حال تمت عملية الشراء والتواصل عن طريق هذا التطبيق", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "أقر بذلك", style: .default, handler: { [self] (_) in
            let id = UUID().uuidString
            let db = Firestore.firestore()
            db.collection("Offers")
                .document(id).setData(["offerTitle": offerTitle.text!,"offerDes":self.offerDes.text!,"price":price.text!,"cate":selectedCat,"userID" : Auth.auth().currentUser!.uid,"offerID": id,"image1": SharedInstanceManager.shared.uploadImage(self.toBeSavedImage1 ?? UIImage()),"city":self.selectedCity,"image2": SharedInstanceManager.shared.uploadImage(self.toBeSavedImage2 ?? UIImage()),"image3": SharedInstanceManager.shared.uploadImage(self.toBeSavedImage3 ?? UIImage()),"image4": SharedInstanceManager.shared.uploadImage(self.toBeSavedImage4 ?? UIImage()), "date": SharedInstanceManager.shared.dateFormatter.string(from: Date()), "lat": self.lat, "log":self.log, "time": Timestamp()])
            self.tabBarController!.selectedIndex = 0
        }))
        alert.addAction(UIAlertAction(title: "إلغاء", style: .default, handler: { (_) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // TO take the 1st image for the will be uploaded offer
    
    @objc func image1BtnClick(_ sender : UIButton){
        toBeSavedImage1Stete = false
        SharedInstanceManager.shared.imagePicker.delegate = self
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
    
    // TO take the 2nd image for the will be uploaded offer
    
    @objc func image2BtnClick(_ sender : UIButton){
        toBeSavedImage2Stete = false
        SharedInstanceManager.shared.imagePicker.delegate = self
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
    
    // TO take the 3rd image for the will be uploaded offer
    
    @objc func image3BtnClick(_ sender : UIButton){
        toBeSavedImage3Stete = false
        SharedInstanceManager.shared.imagePicker.delegate = self
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
    
    // TO take the 4th image for the will be uploaded offer
    
    @objc func image4BtnClick(_ sender : UIButton){
        toBeSavedImage4Stete = false
        SharedInstanceManager.shared.imagePicker.delegate = self
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
               alert.modalPresentationStyle = UIModalPresentationStyle.popover
               alert.popoverPresentationController?.sourceView = view
               alert.popoverPresentationController?.sourceRect = view.bounds
               alert.popoverPresentationController?.permittedArrowDirections = .up
           default:
               break
           }
           
           self.present(alert, animated: true, completion: nil)
        
    }
 
    // To take latitude and longitude of the users' current locatiion
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.lat = locValue.latitude
        self.log = locValue.longitude
    }
}

    // An extension for Pickeing city Picker View
extension AddOfferViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.selectedCity = cities[row]
        return selectedCity
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCity = cities[row]
        print(selectedCity)
    }
}


extension AddOfferViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "وصف المنتج"
            textView.textColor = UIColor.lightGray
        }
    }
}

// An extension for Pickeing images from camera or photo library.

extension AddOfferViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    // Image Picker controller
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // To assign each picked image to the correct variable.
        
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
    
    // Move addOfferView 100 points upward.
    @objc func keyboardWillShow(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillShow(view, -100)
    }

    // Move addOfferView to original position (0).
    @objc func keyboardWillHide(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillHide(view)
    }
    // TO dismiss Keyboard when user just tapped on the specific view.
    @objc func dismissKeyboard() {
        SharedInstanceManager.shared.dismissKeyboard(view)
    }
}

extension AddOfferViewController: UIPopoverPresentationControllerDelegate{
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
    }
}
