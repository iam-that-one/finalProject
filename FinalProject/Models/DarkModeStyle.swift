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
            if darkMode{
                return UIColor.lightGray
            }else{
                return UIColor.black
            }
        }()
        
        public static let header: UIColor = {
            if darkMode{
                return UIColor.darkGray
            }else{
                return UIColor.systemTeal
            }
        }()
        
        public static let mainView: UIColor = {
            if darkMode{
                return UIColor.black
            }else{
                return UIColor.white
            }
        }()
        
        public static let prefView: UIColor = {
            if darkMode{
                return UIColor.darkGray
            }else{
                return UIColor.lightGray
            }
            
        }()
        
        public static let homeCell: UIColor = {
            if darkMode{
                return UIColor.darkGray
            }else{
                return UIColor.lightGray
            }
        }()
        
        public static let tabBar: UIColor = {
            if darkMode{
                return UIColor.darkGray
            }else{
                return UIColor.white
            }
        }()
        
        public static let headerLable: UIColor = {
            if darkMode{
                return UIColor.systemTeal
            }else{
                return UIColor.black
            }
        }()
        
        public static let borderColor: CGColor = {
            if darkMode{
                return .init(gray: 0.10, alpha: 1)
            }else{
                return CGColor.init(gray: 0.90, alpha: 1)
            }
        }()
        
        public static let yellow: UIColor = {
            return UIColor.init(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        }()
    }
    
    public enum Images {
        public static let image: String = {
            if darkMode{
                return "moon.zzz.fill"
            }else{
                return "moon"
            }
            
        }()
    }
}
