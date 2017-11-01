//
//  LoginResult.swift
//  Clockwork
//
//  Created by Ron Lu on 3/09/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import EVReflection

class LoginResult: EVObject {
    
    var apiToken: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var userRoleId: Int = -1
    var userId: String = ""
    
    required init() {
        
    }
}
