//
//  Notify.swift
//  Clockwork
//
//  Created by Ron Lu on 18/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import UserNotifications
import os.log

class Notify{
    
    private init(){
        
    }
    
    class func setIn(dateIn: Date){
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to clock in"
        content.sound = UNNotificationSound.default()
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: dateIn)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        
        let identifier = "clockinID"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                os_log("failed to set clock in notify", type: .error)
            }
        })
        
        
    }
    
    class func setOut(dateOut: Date){
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to clock out"
        content.sound = UNNotificationSound.default()
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: dateOut)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        
        let identifier = "clockoutID"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                os_log("failed to set clock out notify", type: .error)
            }
        })
        
        
    }

    
}
