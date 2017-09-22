//
//  MyDate.swift
//  Clockwork
//
//  Created by Ron Lu on 27/06/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation

class MyDate{

    init(){}
    
    class func format(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    class func between(from: Date, to: Date) -> String{
        let comp = Calendar.current.dateComponents([.hour, .minute, .second], from: from, to: to)
        return "\(comp.hour!)h \(comp.minute!)m"
    }
    
    class func getHour(from: Date, to: Date) -> Int{
        let comp = Calendar.current.dateComponents([.hour, .minute, .second], from: from, to: to)
        return comp.hour!
    }
    
    class func getMin(from: Date, to: Date) -> Int{
        let comp = Calendar.current.dateComponents([.hour, .minute, .second], from: from, to: to)
        return comp.minute!
    }
    
    class func dateToStr(date: NSDate) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date as Date)
    }
}
