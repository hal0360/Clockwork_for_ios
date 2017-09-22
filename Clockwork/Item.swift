//
//  Item.swift
//  Clockwork
//
//  Created by Ron Lu on 5/05/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation

class Item {
    
    var model: Site?
    var active: Bool
    var type: Int
    
    init(type: Int ) {
        self.type = type
        active = false
    }
    
}
