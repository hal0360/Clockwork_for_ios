//
//  Pref.swift
//  Clockwork
//
//  Created by Ron Lu on 28/06/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation

class Pref{
    
    private init(){}
    
    class func getStr(key: String) -> String{
        let reVal = UserDefaults.standard.string(forKey: key)
        if reVal == nil{
            return ""
        }
        return reVal!
    }
    
    class func getBool(key: String, dft: Bool) -> Bool{
        UserDefaults.standard.register(defaults: [key : dft])
        return UserDefaults.standard.bool(forKey: key)
    }
    
    class func getInt(key: String) -> Int{
        return UserDefaults.standard.integer(forKey: key)
    }
    
    class func getFloat(key: String) -> Float{
        return UserDefaults.standard.float(forKey: key)
    }
    
    class func getObj(key: String) -> Any?{
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func set(key: String, value: Any){
        UserDefaults.standard.set(value, forKey: key)
    }
}
