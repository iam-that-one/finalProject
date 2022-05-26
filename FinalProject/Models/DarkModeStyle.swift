//
//  DarkModeStyle.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 26/05/2022.
//

import UIKit

public enum DefaultStyle {
    public enum Colors {
       
        public static let label: UIColor = {
            if status{
                return UIColor.lightGray
            }else{
                return UIColor.black
            }
           
        }()
        
        public static let header: UIColor = {
            if status{
                return UIColor.darkGray
            }else{
                return UIColor.systemTeal
            }
           
        }()
        
        public static let mainView: UIColor = {
            
            if status{
                return UIColor.black
            }else{
                return UIColor.white
            }
           
        }()
        
        public static let prefView: UIColor = {
            if status{
                return UIColor.darkGray
            }else{
                return UIColor.lightGray
            }
           
        }()
        
        public static let homeCell: UIColor = {
            if status{
                return UIColor.darkGray
            }else{
                return UIColor.lightGray
            }
           
        }()
        
        public static let tabBar: UIColor = {
            if status{
                return UIColor.darkGray
            }else{
                return UIColor.white
            }
           
        }()
        
        public static let headerLable: UIColor = {
            if status{
                return UIColor.systemTeal
            }else{
                return UIColor.black
            }
           
        }()
        
        public static let borderColor: CGColor = {
            if status{
                return .init(gray: 0.0, alpha: 1)
            }else{
                return CGColor.init(gray: 0.90, alpha: 1)
            }
           
        }()
    }
}
