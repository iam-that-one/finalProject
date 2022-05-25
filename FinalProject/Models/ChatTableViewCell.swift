//
//  ChatTableViewCell.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 01/01/2022.
//

import Foundation
import UIKit

class ChatTableViewCell: UITableViewCell {

    lazy var verfied : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .black
        return $0
    }(UIImageView())
    
    
    lazy var username : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var date : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = UIColor.black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        return $0
    }(UILabel())
    
    lazy var content : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.backgroundColor = UIColor.lightGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.textColor = .white
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingLeft = 10
        $0.paddingRight = 10
        return $0
    }(PaddingLabel())
  
    lazy var image : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "pngwing.com")
        $0.tintColor = .white
        return $0
    }(UIImageView())
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
      //  contentView.backgroundColor = UIColor.systemGray6
        self.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        [username,date,content, image].forEach{contentView.addSubview($0)}
        
        image.layer.borderColor = .init(gray: 0.50, alpha: 1)
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        
        image.isHidden = true
        NSLayoutConstraint.activate([

            username.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),

          
            content.topAnchor.constraint(equalTo:username.bottomAnchor,constant: 10),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            content.heightAnchor.constraint(equalToConstant: 40),

            image.topAnchor.constraint(equalTo: content.bottomAnchor,constant: 10),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200),
            
            date.topAnchor.constraint(equalTo: content.bottomAnchor,constant: 5),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

