//
//  Profile.swift
//  Clockwork
//
//  Created by Ron Lu on 31/08/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation

class Profile {
    
    class func firstName() -> String{
        return Pref.getStr(key: "firstName")
    }
    
    class func firstName(val: String){
        Pref.set(key: "firstName", value: val)
    }
    
    class func lastName() -> String{
        return Pref.getStr(key: "lastName")
    }
    
    class func lastName(val: String){
        Pref.set(key: "lastName", value: val)
    }
    
    class func userID() -> String{
        return Pref.getStr(key: "userID")
    }
    
    class func userID(val: String){
        Pref.set(key: "userID", value: val)
    }
    
    class func email() -> String{
        return Pref.getStr(key: "email")
    }
    
    class func email(val: String){
        Pref.set(key: "email", value: val)
    }
    
    class func token() -> String{
        return Pref.getStr(key: "token")
    }
    
    class func token(val: String){
        Pref.set(key: "token", value: val)
    }
    
    class func bussID() -> String{
        return Pref.getStr(key: "bussID")
    }
    
    class func bussID(val: String){
        Pref.set(key: "bussID", value: val)
    }
    
    class func company() -> String{
        return Pref.getStr(key: "company")
    }
    
    class func company(val: String){
        Pref.set(key: "company", value: val)
    }
    
    class func role() -> Int{
        return Pref.getInt(key: "role")
    }
    
    class func role(val: Int){
        Pref.set(key: "role", value: val)
    }
  
    class func logout(){
        
    }
}
