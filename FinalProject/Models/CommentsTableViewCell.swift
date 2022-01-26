//
//  CommentsTableViewCell.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 10/01/2022.
//

import UIKit
import Foundation

protocol CommetntTableViewCellDelegate: AnyObject {
  func CommetntTableViewCell(_ CommetntTableViewCel: CommentsTableViewCell, delete comment: Comment)
}
class CommentsTableViewCell: UITableViewCell {

    var comments : Comment?
    weak var delegate : CommetntTableViewCellDelegate?
    
    lazy var deleteBtn : UIButton = {
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "trash.fill"), for: .normal)
        $0.addTarget(self, action: #selector(deleteBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var username : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .black
        $0.textAlignment = .right
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
       // $0.backgroundColor = UIColor.systemIndigo
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.textColor = UIColor.systemIndigo
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingLeft = 10
        $0.paddingRight = 10
        return $0
    }(PaddingLabel())
  
  
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
        contentView.backgroundColor = UIColor.systemGray5
        contentView.layer.cornerRadius = 5
      //  contentView.layer.borderColor = CGColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
      //  contentView.layer.borderWidth = 5
        contentView.layer.shadowRadius = 3.0
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.shadowColor = CGColor.init(gray: 0.50, alpha: 1)
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
        [username,date,content,deleteBtn].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
          
            username.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            content.topAnchor.constraint(equalTo:username.bottomAnchor,constant: 5),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.bottomAnchor.constraint(equalTo: date.topAnchor,constant: -10),
            
          //  date.topAnchor.constraint(equalTo: content.bottomAnchor),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            deleteBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            deleteBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            deleteBtn.heightAnchor.constraint(equalToConstant: 20),
            deleteBtn.widthAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
    @objc func deleteBtnClick(_ sender : UIButton){
        if let comments = comments,
             let _ = delegate {
            self.delegate?.CommetntTableViewCell(self, delete: comments)
          }
        
    }
}
 
