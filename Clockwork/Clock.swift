//
//  Clock.swift
//  Clockwork
//
//  Created by Ron Lu on 17/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation


class Clock{
 
    class func cin() -> String{
        let temp = Pref.getStr(key: "clockIn")
        if temp == "" {
            return "2000-01-01 00:00:00"
        }
        return temp
    }
    
    class func cin(val: String){
        Pref.set(key: "clockIn", value: val)
    }
    
    class func cout() -> String{
        let temp = Pref.getStr(key: "clockOut")
        if temp == "" {
            return "2000-01-01 00:00:00"
        }
        return temp
    }

    class func cout(val: String){
        Pref.set(key: "clockOut", value: val)
    }
}


