//
//  MyCollectionViewCell.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 03/01/2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
     
    override init(frame: CGRect) {
        super.init(frame: .zero)
           setCollectionCiewCell()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setCollectionCiewCell(){
        contentView.addSubview(image)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
       
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.heightAnchor.constraint(equalToConstant: 110),
            image.widthAnchor.constraint(equalToConstant: 110)
        ])
    }

}
