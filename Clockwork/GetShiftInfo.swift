//
//  GetShiftInfo.swift
//  Clockwork
//
//  Created by Ron Lu on 3/09/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import EVReflection

class GetShiftInfo: EVObject {
    
    var start: String?
    var end: String?
    var userIds: Array<String>?
    var projectIds: Array<Int>?
    var max: String?
    
    required init() {
        start = "2000-05-01"
        end = "2037-05-01"
        userIds = [Profile.userID()]
        projectIds = nil
        max = "0"
    }
    
}
