//
//  ProjectCell.swift
//  Clockwork
//
//  Created by Ron Lu on 24/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class ProjectCell: UICollectionViewCell {
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var activeBall: UIView!
    
    //top
    @IBOutlet weak var topContent: UIView!
    @IBOutlet weak var currentStarted: UILabel!
    @IBOutlet weak var currentWorked: UILabel!
    @IBOutlet weak var currentTitle: UILabel!
    @IBOutlet weak var endSessionButton: UIButton!
    var myTimer: Timer? = nil
    
    //project
    @IBOutlet weak var projectContent: UIView!
    @IBOutlet weak var started: UILabel!
    @IBOutlet weak var finished: UILabel!
    @IBOutlet weak var worked: UILabel!
    @IBOutlet weak var totalRecord: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    //total
    @IBOutlet weak var totalContent: UIStackView!
    @IBOutlet weak var yesterday: UILabel!
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var month: UILabel!
    
    func donuh() {
        let curStartDate: Date = (Act.startTime() as? Date)!
        var comp = Calendar.current.dateComponents([.hour, .minute, .second], from: curStartDate, to: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        //print("hours = \(comp.hour!):\(comp.minute!):\(comp.second!)")
        currentStarted.text = formatter.string(from: curStartDate)
        currentWorked.text = "\(comp.hour!):\(comp.minute!):\(comp.second!)"
    }
    
    func setTop() {
        header.backgroundColor = UIColor.green
        activeBall.backgroundColor = UIColor.green
        title.textColor = UIColor.white
        totalContent.isHidden = true
        projectContent.isHidden = true
        topContent.isHidden = false
        title.text = "YOUR DAY TODAY"
        currentTitle.text = Act.current()
        if myTimer == nil {
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(donuh), userInfo: nil, repeats: true)
        }
    }
    
    func setProject(site: Site) {
        totalContent.isHidden = true
        projectContent.isHidden = false
        topContent.isHidden = true
        header.backgroundColor = UIColor.white
        title.textColor = UIColor.orange
        title.text = site.name
        activeBall.layer.cornerRadius = 8
        if(Act.current() == site.name){
            activeBall.backgroundColor = UIColor.green
        }else{
            activeBall.backgroundColor = UIColor.red
        }
        let tPro = site.stamps?.count
        if(tPro! > 0){
            let stamps = ItemMaker.toStamps(stamps: site.stamps!)
            let lastStamp = stamps[0]
            started.text = MyDate.format(date: stamps[0].startTime as! Date)
            finished.text = MyDate.format(date: stamps[0].endTime as! Date)
            worked.text = MyDate.between(from: stamps[0].startTime as! Date, to: lastStamp.endTime as! Date)
        }
        totalRecord.text = "There are \(tPro!) records in this project"
    }
    
    func setTotal() {
        totalContent.isHidden = false
        projectContent.isHidden = true
        topContent.isHidden = true
        header.backgroundColor = UIColor.orange
        activeBall.backgroundColor = UIColor.orange
        title.textColor = UIColor.white
        title.text = "TOTAL"
        let allstamps = ItemMaker.getStamps()
        var hours = 0
        var mins = 0
        for stamp in allstamps {
            hours = hours + MyDate.getHour(from: stamp.startTime as! Date, to: stamp.endTime as! Date)
            mins = mins + MyDate.getMin(from: stamp.startTime as! Date, to: stamp.endTime as! Date)
        }
        hours = hours + mins / 60
        mins = mins % 60
        yesterday.text = "\(hours)h \(mins)m"
        week.text = "\(hours)h \(mins)m"
        month.text = "\(hours)h \(mins)m"
    }
    
}
