//
//  profileTableViewCell.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 06/01/2022.
//

import Foundation
import UIKit
protocol OfferTableViewCellDelegate: AnyObject {
  func myPrfileTableViewCell(_ profileTableViewCel: profileTableViewCell, delete offer: Offer)
    func myPrfileTableViewEditButton(_ profileTableViewCel: profileTableViewCell, delete offer: Offer)
}
class profileTableViewCell: UITableViewCell {

    var offers : Offer?
    weak var delegate : OfferTableViewCellDelegate?
    
    
    lazy var deleteBtn : UIButton = {
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "trash.fill"), for: .normal)
        $0.addTarget(self, action: #selector(deleteBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var updateBtn : UIButton = {
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        $0.addTarget(self, action: #selector(updateBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    
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
        $0.textColor = .gray
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        
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
        [offerImage,title,categoery,price,deleteBtn,updateBtn,date].forEach{contentView.addSubview($0)}
        
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
            
            deleteBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            deleteBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            deleteBtn.heightAnchor.constraint(equalToConstant: 20),
            deleteBtn.widthAnchor.constraint(equalToConstant: 20),
            
            updateBtn.leadingAnchor.constraint(equalTo: deleteBtn.trailingAnchor,constant: 10),
            updateBtn.centerYAnchor.constraint(equalTo: deleteBtn.centerYAnchor),
            updateBtn.heightAnchor.constraint(equalToConstant: 20),
            updateBtn.widthAnchor.constraint(equalToConstant: 20),
            
            date.bottomAnchor.constraint(equalTo: price.topAnchor,constant: -5),
            date.trailingAnchor.constraint(equalTo: offerImage.leadingAnchor,constant: -10)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
    @objc func deleteBtnClick(_ sender : UIButton){
        if let offers = offers,
             let _ = delegate {
            self.delegate?.myPrfileTableViewCell(self,delete: offers)
          }
    }
    
    @objc func updateBtnClick(_ sender : UIButton){
        if let offers = offers,
             let _ = delegate {
            self.delegate?.myPrfileTableViewEditButton(self,delete: offers)
          }
    }
    
    
    
}
