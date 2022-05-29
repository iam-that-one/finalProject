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
        tabBar.layer.cornerRadius = 50
        tabBar.layer.shadowRadius = 10.0
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,]
        tabBar.layer.shadowOpacity = 10.0
        tabBar.layer.shadowColor = CGColor.init(gray: 0.30, alpha: 1)
        tabBar.layer.shadowOffset = CGSize(width: 4, height: 4)
       // tabBar.layer.masksToBounds = true
        tabBarController?.tabBar.items?[3].badgeValue = "5"//
        tabBarController?.tabBar.items?[3].badgeColor = .red
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        let item1 = HomeViewController() //UINavigationController(rootViewController: HomeViewController())
        let item2 = MessagesViewController()
        let item3 = AddOfferViewController()
        let item4 = ProfileViewController()
        let item5 = BookmarksViewController()
       
        item4.tabBarItem.badgeValue = "5"
        item4.tabBarItem.badgeColor = .red
       // self.tabBar.items?[3].badgeValue = nil
        let icon1 = UITabBarItem(title: "الرئيسية", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
            item1.tabBarItem = icon1
        
        let icon2 = UITabBarItem(title: "رسائلي", image: UIImage(systemName: "tray"), selectedImage: UIImage(systemName: "tray.fill"))
            item2.tabBarItem = icon2

        let icon3 = UITabBarItem(title: "إعلان جديد", image: UIImage(systemName: "plus.rectangle"), selectedImage: UIImage(systemName: "plus.rectangle.fill"))
            item3.tabBarItem = icon3

        let icon4 = UITabBarItem(title: "حسابي", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        item4.tabBarItem = icon4
        
        let icon5 = UITabBarItem(title: "تفضيلاتي", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))
        item5.tabBarItem = icon5
        
        self.tabBar.tintColor = .systemTeal
        let controllers = [item1,item5,item3,item2,item4]
        self.viewControllers = controllers
    
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true
    }
}


class TabBarVC: UITabBar {

    private var shapeLayer: CALayer?
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = CGColor.init(red: 3/255, green: 20/255, blue: 30/255, alpha: 1)
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = CGColor.init(red: 3/255, green: 20/255, blue: 30/255, alpha: 1)
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        }else{
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
        self.unselectedItemTintColor = UIColor.white
        self.tintColor = .brown
    }

    func createPath() -> CGPath {
        let height: CGFloat = 15
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: -20)) //start pos
        path.addLine(to: CGPoint(x: centerWidth - 50, y: 0)) //left slope
        path.addQuadCurve(to: CGPoint(x: centerWidth - 30, y: 20), controlPoint: CGPoint(x: centerWidth - 30, y: 5)) //top left curve
        path.addLine(to: CGPoint(x: centerWidth - 29, y: height - 10)) // left vertical line
        path.addQuadCurve(to: CGPoint(x: centerWidth, y: height + 10), controlPoint: CGPoint(x: centerWidth - 30, y: height + 10)) //bottom left curve
        path.addQuadCurve(to: CGPoint(x: centerWidth + 40, y: height - 10), controlPoint: CGPoint(x: centerWidth + 40, y: height + 10)) //bottom right curve
        path.addLine(to: CGPoint(x: centerWidth + 41, y: 20)) //right vertical line
        path.addQuadCurve(to: CGPoint(x: centerWidth + 50, y: 0), controlPoint: CGPoint(x: centerWidth + 41, y: 5)) //top right curve
        path.addLine(to: CGPoint(x: self.frame.width, y: -20)) //right slope
        
        //close the path
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
        
    }
}
