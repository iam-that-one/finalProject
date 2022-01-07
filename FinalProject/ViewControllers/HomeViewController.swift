//
//  ViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 30/12/2021.
//


import UIKit
import Firebase
class HomeViewController: UIViewController {
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
        $0.tintColor = .black
        $0.setTitle("الكل", for: .normal)
        $0.addTarget(self, action: #selector(all), for: .touchDown)
        $0.translatesAutoresizingMaskIntoConstraints = false
       // $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.setBackgroundImage(UIImage(systemName: "squareshape.fill"), for: .normal)
        return $0
    }(UIButton())
    
    lazy var logo2 : UIButton = {
        $0.tintColor = categoery == "أجهزة" ? .black : .darkGray
        $0.setTitle("أجهزة", for: .normal)
        $0.addTarget(self, action: #selector(devices), for: .touchDown)
        $0.translatesAutoresizingMaskIntoConstraints = false
     //   $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.setBackgroundImage(UIImage(systemName: "squareshape.fill"), for: .normal)
        return $0
    }(UIButton())
    
    lazy var logo3 : UIButton = {
        $0.tintColor = categoery == "سيارات" ? .black : .darkGray
        $0.setTitle("سيارات", for: .normal)
    //    $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)

        $0.addTarget(self, action: #selector(cars), for: .touchDown)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "squareshape.fill"), for: .normal)
        return $0
    }(UIButton())
    
    lazy var logo4 : UIButton = {
        $0.tintColor = .darkGray
     //   $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)

        $0.setTitle("", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "squareshape.fill"), for: .normal)
        return $0
    }(UIButton())
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var searchBar : UISearchBar = {
        $0.placeholder = "بحث"
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
    
    lazy var newLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "اسم التطبيق"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    lazy var newButton : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(moveBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    override func viewWillAppear(_ animated: Bool) {
       // Offer.example = temp
        offersTableView.reloadData()
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myColletionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myColletionView!.backgroundColor = UIColor.white
        myColletionView!.dataSource = self
        myColletionView!.delegate = self
        myColletionView!.backgroundColor = .darkGray
        myColletionView!.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "coleectionViewCell")
        //self.navigationController?.navigationBar.tintColor = .clear
        animateTableView()
        stackView.alignment = .fill // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        stackView.distribution = .fill // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(logo2)
        stackView.addArrangedSubview(logo3)
        stackView.addArrangedSubview(logo4)
     //   temp = Offer.example
        getOffers()
        [newLable,newButton, searchBar,stackView,offersTableView].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            newLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            newLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            newButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            
            searchBar.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 20),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: 350),
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100),
            
            logo2.widthAnchor.constraint(equalToConstant: 100),
            logo2.heightAnchor.constraint(equalToConstant: 100),
            
            logo3.widthAnchor.constraint(equalToConstant: 100),
            logo3.heightAnchor.constraint(equalToConstant: 100),
            
            logo4.widthAnchor.constraint(equalToConstant: 100),
            logo4.heightAnchor.constraint(equalToConstant: 100),
            
            offersTableView.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 10),
            offersTableView.widthAnchor.constraint(equalToConstant: 380),
            offersTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            offersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
    }
    func getOffers(){
        
        db.collection("Offers")
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error while fetching profile\(error)")
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
                            
                            self.offers.append(Offer(title: offerTitle, description: offerDes, price: price, userID: userID, offerID: offerID, date: date, city: city, categoery: cat, image1: image1, image2: image2, image3: image3, image4: image4))
                        }
                        self.offersTableView.reloadData()
                        
                      
                    }
                }
            }
    }
    @objc func moveBtnClick(){
    }
    @objc func devices(){
        logo2.tintColor = .black
        logo.tintColor = .darkGray
        logo3.tintColor = .darkGray
        categoery = "أجهزة"
        if offers.isEmpty{
        getOffers()
        }
        offers = offers.filter{$0.categoery == categoery}
        offersTableView.reloadData()
        animateTableView()
    }
    @objc func cars(){
      //  offers = []
        animateTableView()
        logo3.tintColor = .black
        logo.tintColor = .darkGray
        logo2.tintColor = .darkGray
        categoery = "سيارات"
        if offers.isEmpty{
        getOffers()
        }
        offers = offers.filter{$0.categoery == categoery}
        offersTableView.reloadData()

    }
    @objc func all(){
        animateTableView()
        logo.tintColor = .black
        logo3.tintColor = .darkGray
        logo2.tintColor = .darkGray
        offers = []
        getOffers()
        offersTableView.reloadData()

    }
    func animateTableView(){
        UIView.transition(with: offersTableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: { self.offersTableView.reloadData() })
    }
    
    var dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm E, d MMM y"
          formatter.dateStyle = .medium
          formatter.timeStyle = .medium
          return formatter
      }()
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count// Offer.example.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = offersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OffersTableViewCell
        cell.offerImage.image = UIImage(data:offers[indexPath.row].image1) ?? UIImage()
        cell.title.text = offers[indexPath.row].title
        let date = dateFormatter.date(from: offers[indexPath.row].date)
        cell.price.text = offers[indexPath.row].price
        cell.date.text = date?.timeAgoDisplay()
        cell.categoery.text = "#" + offers[indexPath.row].categoery
        cell.city.text = offers[indexPath.row].city
        return cell
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OfferDetailsViewController()
        vc.offer = offers[indexPath.row]
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
