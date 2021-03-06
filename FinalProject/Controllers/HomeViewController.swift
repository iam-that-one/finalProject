//
//  ViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 30/12/2021.
//


import UIKit
import Firebase

class HomeViewController: UIViewController  {

    lazy var logo0000 : UIButton = {
        $0.tintColor = .systemTeal
        $0.setTitle("عقارات", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(realEstate), for: .touchDown)
       // $0.layer.cornerRadius = 5
        $0.layer.borderColor = .init(gray: 0.0, alpha: 1)
        
        $0.layer.borderWidth = 3
        $0.backgroundColor = .lightGray// UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font =  UIFont(name: "ReemKufi", size: 18)
       // $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
      //  $0.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
       
        return $0
    }(UIButton())
    
    lazy var logo1111 : UIButton = {
        $0.tintColor = .systemTeal
        $0.setTitle("أزياء", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(clothes), for: .touchDown)
       // $0.layer.cornerRadius = 5
        $0.layer.borderColor = .init(gray: 0.0, alpha: 1)
        
        $0.layer.borderWidth = 3
        $0.backgroundColor = .lightGray// UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font =  UIFont(name: "ReemKufi", size: 18)
       // $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
      //  $0.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
       
        return $0
    }(UIButton())
    
    let simpleOver = SimpleOver()
   
    var filterdResult : [Offer] = []
    lazy var myColletionView : UICollectionView? = nil
    var offers : [Offer] = []
    let db = Firestore.firestore()
    var categoery = ""
    var temp : [Offer] = []
    lazy var stackView : UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 9
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    lazy var logo : UIButton = {
        $0.tintColor = .systemTeal
        $0.setTitle("الكل", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(all), for: .touchDown)
       // $0.layer.cornerRadius = 5
        $0.layer.borderColor = .init(gray: 0.0, alpha: 1)
        
        $0.layer.borderWidth = 3
        $0.backgroundColor = .systemTeal// UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font =  UIFont(name: "ReemKufi", size: 18)
       // $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
      //  $0.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
       
        return $0
    }(UIButton())
    
    lazy var logo2 : UIButton = {
        $0.tintColor = .clear
        $0.setTitle("أجهزة", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(devices), for: .touchDown)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = .init(gray: 0.0, alpha: 1)
        $0.layer.borderWidth = 3
        $0.backgroundColor = .lightGray//UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font =  UIFont(name: "ReemKufi", size: 20)
     //   $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        //$0.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        return $0
    }(UIButton())
    
    lazy var logo3 : UIButton = {
        $0.tintColor = .clear
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("سيارات", for: .normal)
    //    $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(cars), for: .touchDown)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = .init(gray: 0.0, alpha: 1)
        $0.layer.borderWidth = 3
        $0.backgroundColor = .lightGray//UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font =  UIFont(name: "ReemKufi", size: 20)
        //$0.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        return $0
    }(UIButton())
    
    lazy var sc : UIScrollView = {
     //   $0.delegate = self
        $0.contentSize = CGSize(width: 550, height: 90)
        $0.showsHorizontalScrollIndicator = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())
    lazy var logo4 : UIButton = {
        $0.tintColor = .clear
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("خدمات", for: .normal)
        $0.addTarget(self, action: #selector(other), for: .touchDown)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = .init(gray: 0.0, alpha: 1)
        $0.layer.borderWidth = 3
        $0.backgroundColor = .lightGray//UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
      //  $0.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        $0.titleLabel?.font =  UIFont(name: "ReemKufi", size: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var searchBar : UISearchBar = {
        $0.placeholder = "بحث"
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
      return $0
    }(UISearchBar())
    
    lazy var offersTableView : UITableView = {
        $0.register(OffersTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    lazy var newLable : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "تشتري؟"
        $0.textColor = DefaultStyle.Colors.label
        $0.textAlignment = .center
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        $0.clipsToBounds = true
       // $0.shadowColor = .init(cgColor: .init(gray: 0.50, alpha: 1))
        //$0.shadowOffset = .init(width: 2, height: 5)
       // $0.backgroundColor = DefaultStyle.self.Colors.header//UIClor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.paddingTop = 20
        $0.font = UIFont(name: "ReemKufi-Bold", size: 30)
      //  $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(PaddingLabel())
    lazy var newButton : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(moveBtnClick), for: .touchDown)
        return $0
        
    }(UIButton(type: .system))
    override func viewWillAppear(_ animated: Bool) {
        offersTableView.reloadData()
        newLable.backgroundColor = DefaultStyle.self.Colors.header
        navigationController?.setNavigationBarHidden(true, animated: animated)
       //  status = UserDefaults.standard.bool(forKey: "isDarkMode")
     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       // offers = []
       // filterdResult = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       // sc.delegate = self
      //  offersTableView.showsVerticalScrollIndicator = false
        view.backgroundColor = DefaultStyle.self.Colors.mainView
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            searchBar.layer.cornerRadius = 20
            searchBar.clipsToBounds = true
         //   offersTableView.backgroundColor = .systemGray3
        default:
            view.backgroundColor = DefaultStyle.Colors.mainView
            break
        }

        myColletionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myColletionView!.backgroundColor = UIColor.white
        myColletionView!.dataSource = self
        myColletionView!.delegate = self
        myColletionView!.backgroundColor = .darkGray
        myColletionView!.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "coleectionViewCell")
        
        animateTableView()
        
        stackView.alignment = .leading // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        stackView.distribution = .fill // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(logo2)
        stackView.addArrangedSubview(logo3)
        stackView.addArrangedSubview(logo4)
        stackView.addArrangedSubview(logo0000)
        stackView.addArrangedSubview(logo1111)
        sc.addSubview(stackView)
        getMessages()
        getOffers()
        temp = offers
        [newLable, searchBar,sc,offersTableView].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            searchBar.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 20),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            
            sc.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 20),
            sc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sc.heightAnchor.constraint(equalToConstant: 90),
           // sc.bottomAnchor.constraint(equalTo: offersTableView.topAnchor,constant: -20),
            sc.widthAnchor.constraint(equalToConstant: 350),
            
            stackView.leadingAnchor.constraint(equalTo: sc.leadingAnchor),
           // stackView.trailingAnchor.constraint(equalTo: sc.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 110),
            
            logo.widthAnchor.constraint(equalToConstant: 80),
            logo.heightAnchor.constraint(equalToConstant: 80),
            
            logo2.widthAnchor.constraint(equalToConstant: 80),
            logo2.heightAnchor.constraint(equalToConstant: 80),
            
            logo3.widthAnchor.constraint(equalToConstant: 80),
            logo3.heightAnchor.constraint(equalToConstant: 80),
            
            logo4.widthAnchor.constraint(equalToConstant: 80),
            logo4.heightAnchor.constraint(equalToConstant: 80),
            
            logo0000.widthAnchor.constraint(equalToConstant: 80),
            logo0000.heightAnchor.constraint(equalToConstant: 80),
            
            logo1111.widthAnchor.constraint(equalToConstant: 80),
            logo1111.heightAnchor.constraint(equalToConstant: 80),
            
            
            offersTableView.topAnchor.constraint(equalTo: sc.bottomAnchor,constant: 10),
            offersTableView.widthAnchor.constraint(equalToConstant: 380),
            offersTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            offersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
    }
    func getOffers(){
        db.collection("Offers")
            .order(by: "time",descending: true)
            .addSnapshotListener { [self] (querySnapshot, error) in
                if let error = error {
                    print("Error while fetching offers\(error)")
                } else {
                    filterdResult = []
                    offers = []
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let userID = data["userID"] as? String ?? ""
                            let offerID = data["offerID"] as? String ?? ""
                            let date = data["date"] as? String ?? ""
                            let offerTitle = data["offerTitle"] as? String ?? ""
                            let offerDes = data["offerDes"] as? String ?? ""
                            let price = data["price"] as? String ?? ""
                            let city = data["city"] as? String ?? ""
                            let cat = data["cate"] as? String ?? ""
                            let image1 = data["image1"] as? Data ?? Data()
                            let image2 = data["image2"] as? Data ?? Data()
                            let image3 = data["image3"] as? Data ?? Data()
                            let image4 = data["image4"] as? Data ?? Data()
                            let lat = data["lat"] as? Double ?? 0.0
                            let log = data["log"] as? Double ?? 0.0
                            
                            self.offers.append(Offer(title: offerTitle, description: offerDes, price: price, userID: userID, offerID: offerID, date:  self.dateFormatter.date(from: date) ?? Date(),lat: lat ,log: log, city: city, categoery: cat, image1: image1, image2: image2, image3: image3, image4: image4))
                            
                            self.filterdResult.append(Offer(title: offerTitle, description: offerDes, price: price, userID: userID, offerID: offerID, date:  self.dateFormatter.date(from: date) ?? Date(),lat: lat ,log: log, city: city, categoery: cat, image1: image1, image2: image2, image3: image3, image4: image4))
                        }
                        self.offersTableView.reloadData()
                    }
                }
            }
    }
    func filterOffers(_ categoery : String){
        db.collection("Offers")
            .order(by: "time",descending: true)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error while fetching offers\(error)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let userID = data["userID"] as? String ?? ""
                            let offerID = data["offerID"] as? String ?? ""
                            let date = data["date"] as? String ?? ""
                            let offerTitle = data["offerTitle"] as? String ?? ""
                            let offerDes = data["offerDes"] as? String ?? ""
                            let price = data["price"] as? String ?? ""
                            let city = data["city"] as? String ?? ""
                            let cat = data["cate"] as? String ?? ""
                            let image1 = data["image1"] as? Data ?? Data()
                            let image2 = data["image2"] as? Data ?? Data()
                            let image3 = data["image3"] as? Data ?? Data()
                            let image4 = data["image4"] as? Data ?? Data()
                            let lat = data["lat"] as? Double ?? 0.0
                            let log = data["log"] as? Double ?? 0.0
                            
                            if cat == categoery{
                                self.offers.append(Offer(title: offerTitle, description: offerDes, price: price, userID: userID, offerID: offerID, date:  self.dateFormatter.date(from: date) ?? Date() ,lat: lat ,log: log,city: city, categoery: cat, image1: image1, image2: image2, image3: image3, image4: image4))
                                self.filterdResult.append(Offer(title: offerTitle, description: offerDes, price: price, userID: userID, offerID: offerID, date: self.dateFormatter.date(from: date) ?? Date(),lat: lat ,log: log,city: city, categoery: cat, image1: image1, image2: image2, image3: image3, image4: image4))
                            }
                            self.offersTableView.reloadData()
                        }
                    }
                }
            }
    }
    @objc func moveBtnClick(){
    }
    @objc func devices(){
        logo2.backgroundColor = .systemTeal
        logo3.backgroundColor = .lightGray
        logo4.backgroundColor = .lightGray
        logo0000.backgroundColor = .lightGray
        logo.backgroundColor = .lightGray
        logo1111.backgroundColor = .lightGray
          categoery = "أجهزة"
        searchBar.text = ""
        offers.removeAll{$0.categoery == "أجهزة"}
        filterdResult = []
        filterOffers(categoery)
          animateTableView()
      }
    
    @objc func realEstate(){
        logo0000.backgroundColor = .systemTeal
        logo3.backgroundColor = .lightGray
        logo4.backgroundColor = .lightGray
        logo.backgroundColor = .lightGray
        logo1111.backgroundColor = .lightGray
          categoery = "عقارات"
        searchBar.text = ""
        offers.removeAll{$0.categoery == "عقارات"}
        filterdResult = []
        filterOffers(categoery)
          animateTableView()
      }
    
    @objc func clothes(){
        logo0000.backgroundColor = .lightGray
        logo3.backgroundColor = .lightGray
        logo4.backgroundColor = .lightGray
        logo.backgroundColor = .lightGray
        logo1111.backgroundColor = .systemTeal
          categoery = "أزياء"
        searchBar.text = ""
        offers.removeAll{$0.categoery == "أزياء"}
        filterdResult = []
        filterOffers(categoery)
          animateTableView()
      }
    
    
      @objc func cars(){
          animateTableView()
          logo3.backgroundColor = .systemTeal
          logo2.backgroundColor = .lightGray
          logo4.backgroundColor = .lightGray
          logo.backgroundColor = .lightGray
          logo0000.backgroundColor = .lightGray
          logo1111.backgroundColor = .lightGray
          categoery = "سيارات"
          searchBar.text = ""
          offers.removeAll{$0.categoery == "سيارات"}
          filterdResult = []
          filterOffers(categoery)
          offersTableView.reloadData()
      }
    @objc func other(){
        animateTableView()
        logo.backgroundColor = .lightGray
        logo2.backgroundColor = .lightGray
        logo4.backgroundColor = .systemTeal
        logo3.backgroundColor = .lightGray
        logo0000.backgroundColor = .lightGray
        logo1111.backgroundColor = .lightGray

        categoery = "خدمات"
        searchBar.text = ""
        offers.removeAll{$0.categoery == "خدمات"}
        filterdResult = []
        filterOffers(categoery)
        
    }
    
      @objc func all(){
          animateTableView()
          logo.backgroundColor = .systemTeal
          logo3.backgroundColor = .lightGray
          logo2.backgroundColor = .lightGray
          logo4.backgroundColor = .lightGray
          logo0000.backgroundColor = .lightGray
          logo1111.backgroundColor = .lightGray
          filterdResult = []
          offers = []
          getOffers()

      }
    func animateTableView(){
        UIView.transition(with: offersTableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: {
        })
    }
    var dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm E, d MMM y"
          formatter.dateStyle = .medium
          formatter.timeStyle = .medium
          return formatter
      }()
    // Move lofin view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillShow(view, -50)
    }

    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
        SharedInstanceManager.shared.keyboardWillHide(view)
    }
    @objc func dismissKeyboard() {
        SharedInstanceManager.shared.dismissKeyboard(view)
    }
    
    
    var ids : [String] = []
    var offerProviderId = ""
    var recntChates : [RecentChat] = []
 

        func getMessages(){
           let read = UserDefaults.standard.value(forKey: "bad24") as? Int ?? 0
        db.collection("RecentMessages").addSnapshotListener { querySnapshot, error in
            if let error = error{
                print(error)
            }else{
                var content = ""
                self.recntChates = []
                for doc in querySnapshot!.documents{
                    let data = doc.data()
                    let date = data["date"] as? Date ?? Date()
                    let time = data["time"] as? Timestamp ?? Timestamp()
                    let reciverId = data["reciverId"] as? String ?? ""
                    self.offerProviderId = data["senderId"] as? String ?? ""
                    print("reciver",reciverId)
                    let senderId = data["senderId"] as? String ?? ""
                    content = data["content"] as? String ?? ""
                    print("sender", senderId)
                    if reciverId == Auth.auth().currentUser!.uid{
                        self.ids.append(senderId)
                        self.db.collection("offers_users").addSnapshotListener {[self] querySnapshot, error in
                            if let error = error{
                                print(error)
                            }else{
                                for doc in querySnapshot!.documents{
                                    print("idddddddddddddddd",doc.documentID)
                                    let data = doc.data()
                                    let id = data["uid"] as? String ?? ""
                                    let profilePic = data["image"] as? Data ?? Data()
                                    let name = data["firstName"] as? String ?? ""
                                    let lastName = data["lastName"] as? String ?? ""
                                    if self.ids.contains(id){
                                        self.recntChates.append(RecentChat(name: name + " " + lastName , id: id, date: date, profilePic: profilePic,time: time, content: content))
                                      //  self.filterdResult = self.recntChates
                                        self.ids.removeAll{$0 == id}
                                        if self.recntChates.count > read && recntChates.last!.id != senderId{
                                            SharedInstanceManager.shared.playAudioAsset("Tri Tone iphone Xs Message Ringtone Mp3 Ringtone")
                                        }
                                        UserDefaults.standard.set(self.recntChates.count, forKey: "bad24")
                                        self.tabBarController?.tabBar.items?[3].badgeValue = "\(read == 0 ? self.recntChates.count : self.recntChates.count - read)"
                                        if self.recntChates.count - read == 0 || self.recntChates.count == 0{
                                            self.tabBarController?.tabBar.items?[3].badgeValue = nil
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdResult.count// Offer.example.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = offersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OffersTableViewCell
        cell.offerImage.image = UIImage(data:filterdResult[indexPath.row].image1) ?? UIImage()
        cell.title.text = filterdResult[indexPath.row].title
        //let date = dateFormatter.string(from: filterdResult[indexPath.row].date)
        cell.price.text = filterdResult[indexPath.row].price + " ريال سعودي"
        cell.date.text = filterdResult[indexPath.row].date.timeAgoDisplay()
        cell.categoery.text = "#" + filterdResult[indexPath.row].categoery
        cell.city.text = filterdResult[indexPath.row].city
        cell.delegate = self
        if indexPath.row % 2 == 0{
            cell.contentView.backgroundColor = UIColor.systemGray6 //UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        }else{
            cell.contentView.backgroundColor = DefaultStyle.Colors.homeCell
        }
        return cell
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OfferDetailsViewController()
        vc.offer = filterdResult[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myColletionView!.dequeueReusableCell(withReuseIdentifier: "coleectionViewCell", for: indexPath) as! MyCollectionViewCell
      //  cell.image.image = Offer.example[indexPath.row].image2
        return cell
    }
    
    
}

extension HomeViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterdResult = []
        let firstIttem = CGPoint(x: 0, y: sc.contentSize.height - sc.bounds.height + sc.contentInset.bottom)
        sc.setContentOffset(firstIttem, animated: true)
        logo.backgroundColor = .systemTeal
        logo3.backgroundColor = .white
        logo2.backgroundColor = .white
        logo4.backgroundColor = .white
        logo0000.backgroundColor = .white
        logo1111.backgroundColor = .white
        if searchText == ""{
           filterdResult = offers
        }
        else{
        for offer in offers{
            if offer.title.lowercased().contains(searchText.lowercased()){
                filterdResult.append(offer)
            }
        }
    }
       offersTableView.reloadData()
    }
    
}
extension HomeViewController : OfferTableViewCellMapDelegate {
    func myHomeTableViewCell(_ HomeTableViewCel: OffersTableViewCell, move offer: Offer) {
        print("Delegate")
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate{
    func navigationController(
          _ navigationController: UINavigationController,
          animationControllerFor operation: UINavigationController.Operation,
          from fromVC: UIViewController,
          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
          
          simpleOver.popStyle = (operation == .pop)
          return simpleOver
      }
}

//extension HomeViewController : UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y != 0 {
//            scrollView.contentOffset.y = 0
//        }
//    }
//
//}

