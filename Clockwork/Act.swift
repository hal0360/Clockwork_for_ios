//
//  Act.swift
//  Clockwork
//
//  Created by Ron Lu on 31/08/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation

class Act {
    class func current() -> String{
        return Pref.getStr(key: "current")
    }
    
    class func current(val: String){
        Pref.set(key: "current", value: val)
    }
    
    class func newSite() -> String{
        return Pref.getStr(key: "newSite")
    }
    
    class func newSite(val: String){
        Pref.set(key: "newSite", value: val)
    }
    
    class func startTime() -> Any?{
        return Pref.getObj(key: "startTime")
    }
    
    class func startTime(val: Any){
        Pref.set(key: "startTime", value: val)
    }
}
