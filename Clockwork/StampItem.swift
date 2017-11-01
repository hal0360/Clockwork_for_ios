//
//  StampItem.swift
//  Clockwork
//
//  Created by Ron Lu on 27/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
class StampItem {
    
    var model: Stamp?
    var type: Int
    var date: String?
    var total: String?
    
    init(type: Int ) {
        self.type = type
    }
    
}
