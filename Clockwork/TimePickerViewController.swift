//
//  TimePickerViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 1/09/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class TimePickerViewController: RootViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
        
        if(Temp.clkInSel){
            timePicker.date = dateFormatter.date(from: Clock.cin())!
        }
        else{
            timePicker.date = dateFormatter.date(from: Clock.cout())!
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: timePicker.date)
        
        if(Temp.clkInSel){
            Notify.setIn(dateIn: timePicker.date)
            Clock.cin(val: dateString)
        }
        else{
            Notify.setOut(dateOut: timePicker.date)
            Clock.cout(val: dateString)
        }
        self.view.removeFromSuperview()
    }
}
