//
//  OffersTableViewCell.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 31/12/2021.
//

import Foundation
import UIKit

class OffersTableViewCell: UITableViewCell {

    lazy var city : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    lazy var offerImage : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "photo")
        $0.tintColor = .black
        return $0
    }(UIImageView())
    
    lazy var title : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Lable"
        $0.textColor = .black
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var price : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Lable"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var categoery : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Lable"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var date : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .darkGray
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        return $0
        
    }(UILabel())
    
    lazy var pin : UIButton = {
        $0.setBackgroundImage(UIImage(named: "pin"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(moveToMapView), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 3, bottom: 10, right: 3))
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellSettings()
    }
    
    func cellSettings(){
        contentView.backgroundColor = UIColor.systemGray6
        contentView.layer.cornerRadius = 10
        [offerImage,title,categoery,price,date,pin,city].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            offerImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            offerImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            offerImage.widthAnchor.constraint(equalToConstant: 110),
            offerImage.heightAnchor.constraint(equalToConstant: 120),
            offerImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            title.trailingAnchor.constraint(equalTo: offerImage.leadingAnchor,constant: -5),
            title.widthAnchor.constraint(equalToConstant: 200),
            
            categoery.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            categoery.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            
            price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            price.trailingAnchor.constraint(equalTo: offerImage.leadingAnchor,constant: -5),
            
            date.bottomAnchor.constraint(equalTo: price.topAnchor,constant: -5),
            date.trailingAnchor.constraint(equalTo: offerImage.leadingAnchor,constant: -10),
            
            city.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            city.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            
            pin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            pin.bottomAnchor.constraint(equalTo: city.topAnchor,constant: -5),
            pin.widthAnchor.constraint(equalToConstant: 20),
            pin.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
    @objc func moveToMapView(){
        
    }
}
