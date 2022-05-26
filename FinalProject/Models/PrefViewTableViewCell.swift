//
//  PrefViewTableViewCell.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 23/05/2022.
//

import Foundation
import UIKit

class PrefViewTableViewCell: UITableViewCell {

    lazy var lable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "لجين"
        $0.textColor = DefaultStyle.Colors.label
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
 
    lazy var logo : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.tintColor = .black
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
        contentView.backgroundColor = DefaultStyle.Colors.prefView
        contentView.layer.cornerRadius = 10
        [lable,logo].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            logo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            logo.widthAnchor.constraint(equalToConstant: 80),
            logo.heightAnchor.constraint(equalToConstant: 90),
            
            lable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            lable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
           
        
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
 
