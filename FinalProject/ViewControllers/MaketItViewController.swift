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
       // $0.contentMode = .scaleToFill
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
