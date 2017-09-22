//
//  LoginInfo.swift
//  Clockwork
//
//  Created by Ron Lu on 31/08/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import EVReflection

class LoginInfo: EVObject {
    
    var FirstName: String?
    var LastName: String?
    var Email: String?
    var Password: String?
    var PasswordToConfirm: String?
    
    
    init(fName: String, lName:String, mail:String, pass:String) {
        FirstName = fName
        LastName = lName
        Email = mail
        Password = pass
        PasswordToConfirm = pass
    }
    
    required init() {
        
    }
    
}
