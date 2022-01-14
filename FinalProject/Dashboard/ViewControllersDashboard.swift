//
//  ViewControllersDashboard.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 31/12/2021.
//

import Foundation
import UIKit

class DashboardTabBarController: UITabBarController, UITabBarControllerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
      
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        let item1 = HomeViewController()
        let item2 = MessagesViewController()
        let item3 = AddOfferViewController()
        let item4 = ProfileViewController()
       
        
        let icon1 = UITabBarItem(title: "الرئيسية", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
            item1.tabBarItem = icon1
        
        let icon2 = UITabBarItem(title: "رسائلي", image: UIImage(systemName: "tray"), selectedImage: UIImage(systemName: "tray.fill"))
            item2.tabBarItem = icon2

        let icon3 = UITabBarItem(title: "إعلان جديد", image: UIImage(systemName: "plus.rectangle"), selectedImage: UIImage(systemName: "plus.rectangle.fill"))
            item3.tabBarItem = icon3

        let icon4 = UITabBarItem(title: "حسابي", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        item4.tabBarItem = icon4
       
        let controllers = [item1,item2,item3,item4]
        self.viewControllers = controllers
    
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true
    }
}
