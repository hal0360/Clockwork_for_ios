//
//  Setting.swift
//  Clockwork
//
//  Created by Ron Lu on 31/08/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation

class Setting {
    
    class func wifi() -> Bool{
        return Pref.getBool(key: "wifi", dft: false)
    }
    
    class func wifi(val: Bool){
         Pref.set(key: "wifi", value: val)
    }
    
    class func notification() -> Bool{
        return Pref.getBool(key: "notification", dft: true)
    }
    
    class func notification(val: Bool){
        Pref.set(key: "notification", value: val)
    }
    
    class func wedge() -> Bool{
        return Pref.getBool(key: "wedge", dft: true)
    }
    
    class func wedge(val: Bool){
        Pref.set(key: "wedge", value: val)
    }
    
    class func reminder() -> Bool{
        return Pref.getBool(key: "reminder", dft: true)
    }
    
    class func reminder(val: Bool){
        Pref.set(key: "reminder", value: val)
    }
    
    
}
