//
//  ChatTableViewCell.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 01/01/2022.
//

import Foundation
import UIKit

class MessagsTableViewCell: UITableViewCell {

    lazy var username : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "لجين"
        $0.textColor = .black
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var date : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    lazy var progilePic : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.tintColor = .darkGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40
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
        contentView.backgroundColor = UIColor.systemGray6
        contentView.layer.cornerRadius = 10
        [username,date,progilePic].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            progilePic.topAnchor.constraint(equalTo: contentView.topAnchor),
            progilePic.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            progilePic.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            progilePic.widthAnchor.constraint(equalToConstant: 80),
            progilePic.heightAnchor.constraint(equalToConstant: 90),
            
            username.trailingAnchor.constraint(equalTo: progilePic.leadingAnchor,constant: -20),
            username.centerYAnchor.constraint(equalTo: progilePic.centerYAnchor),
            
            date.centerYAnchor.constraint(equalTo: username.centerYAnchor),
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20)
        
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
 
