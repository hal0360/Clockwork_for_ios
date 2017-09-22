//
//  Shift.swift
//  Clockwork
//
//  Created by Ron Lu on 25/06/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import EVReflection

class Shift: EVObject {
    
    var qrCodeIdentifier: String?
    var shiftTimeStartOnUtc: String?
    var shiftTimeEndOnUtc: String?
    var comment: String?
    var userId: String?
    
    required init() {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        shiftTimeEndOnUtc = dateFormatter.string(from:date as Date)
        shiftTimeStartOnUtc = dateFormatter.string(from:date as Date)
    }
    
}
