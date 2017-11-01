//
//  SettingViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 27/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class SettingViewController: NaviViewController {

    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var notiSwitch: UISwitch!
    @IBOutlet weak var remindSwitch: UISwitch!
    @IBOutlet weak var clockInTxt: UILabel!
    @IBOutlet weak var clockOutTxt: UILabel!
    @IBOutlet weak var clockInTab: UIView!
    @IBOutlet weak var clockOutTab: UIView!
    @IBOutlet weak var workDaysTab: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Setting.wifi() {
            wifiSwitch.isOn = true
        }
        if Setting.notification() {
            notiSwitch.isOn = true
        }
        if Setting.reminder() {
            remindSwitch.isOn = true
        }
        else{
            clockInTab.isHidden = true
            clockOutTab.isHidden = true
            workDaysTab.isHidden = true
        }
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.clockIn(sender:)))
        self.clockInTab.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.clockOut(sender:)))
        self.clockOutTab.addGestureRecognizer(gesture2)
        clockInTxt.text = MyDate.reformat(dateStr: Clock.cin())
        clockOutTxt.text = MyDate.reformat(dateStr: Clock.cout())
    }
    
    func clockIn(sender : UITapGestureRecognizer) {
        Temp.clkInSel = true
        Kit.pop(contex: mainVC!, id: "TimePickerVC")
    }
    
    func clockOut(sender : UITapGestureRecognizer) {
        Temp.clkInSel = false
        Kit.pop(contex: mainVC!, id: "TimePickerVC")
    }
    
    @IBAction func wifi(_ sender: UISwitch) {
        if sender.isOn == true{
            Setting.wifi(val: true)
        }
        else{
            Setting.wifi(val: false)
        }
    }
    
    @IBAction func notification(_ sender: UISwitch) {
        if sender.isOn == true{
            Setting.notification(val: true)
        }
        else{
            Setting.notification(val: false)
        }
    }
    
    @IBAction func reminder(_ sender: UISwitch) {
        if sender.isOn == true{
            Setting.reminder(val: true)
            clockInTab.isHidden = false
            clockOutTab.isHidden = false
            workDaysTab.isHidden = false
        }
        else{
            Setting.reminder(val: false)
            clockInTab.isHidden = true
            clockOutTab.isHidden = true
            workDaysTab.isHidden = true
        }
    }
}
