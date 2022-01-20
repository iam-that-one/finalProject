//
//  MaketItViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 20/01/2022.
//

import UIKit

class MaketItViewController: UIViewController {

    var image = Data()
    lazy var imageVIew : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = CGColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.layer.borderWidth = 3
        $0.backgroundColor = .white
        return $0
    }(UIImageView())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageVIew)
        imageVIew.image = UIImage(data: image)
        imageVIew.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageVIew.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageVIew.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageVIew.widthAnchor.constraint(equalToConstant: 350).isActive = true
       // imageVIew.contentMode = .scaleAspectFit
    }
    


}
