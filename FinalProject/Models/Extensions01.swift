//
//  Extensions.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 06/01/2022.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
    
        //let month = 4 * week
       // let year = 12 * month
        if secondsAgo < minute {
            return"قبل \(secondsAgo) ثانية"
        } else if secondsAgo < hour {
            return "قبل \(secondsAgo / minute) دقيقة"
        } else if secondsAgo < day {
            return "قبل \(secondsAgo / hour) ساعة"
        } else if secondsAgo < week {
            return "قبل \(secondsAgo / day) يوم"
        }
        /*
        else if secondsAgo < week {
            return "قبل \(secondsAgo / week) أسبوع"
        }
        else if secondsAgo < month {
            return "قبل \(secondsAgo / month) شهر"
        }
        */
        return "قبل \(secondsAgo / week) أسبوع"
    }
}
