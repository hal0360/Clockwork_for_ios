//
//  WorkerHomeViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 6/03/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import UIKit

class WorkerHomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var workerCollectionView: UICollectionView!
    @IBOutlet weak var actionBar: UIView!
    @IBOutlet weak var myTeamButton: UIView!
    @IBOutlet weak var upgradeButton: UIView!
    
    var menuShowing = false
    var itemArray = Array<Item>()
    var selectedIndexPath: IndexPath? = nil
    var myTimer: Timer? = nil
    var newStamp: Stamp? = nil
    var curSite: Site? = nil
    var topCel: WorkerSiteCollectionViewCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuConstraint.constant  = -200
        activityButton.layer.cornerRadius = 5
        
        if Profile.role() == 1{
            actionBar.backgroundColor = .orange
            sideMenuView.backgroundColor = .orange
            myTeamButton.isHidden = true
            upgradeButton.isHidden = false
            
        }else{
            actionBar.backgroundColor =  UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
            sideMenuView.backgroundColor =  UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
            myTeamButton.isHidden = false
            upgradeButton.isHidden = true
        }
        
    }
    
    func setUp(){
        itemArray = ItemMaker.getSiteItems()
        curSite = ItemMaker.findSite(name: Act.current())
        
        if(curSite != nil){
            let item = Item(type: 0)
            itemArray.insert(item, at: 0)
        }
        else{
            Act.current(val: "")
        }

        if myTimer != nil {
            myTimer?.invalidate()
            myTimer = nil
        }
       
        if(Act.current() == ""){
            activityButton.setTitle("START ACTIVITY", for: .normal)
        }
        else{
            activityButton.setTitle("FINISH ACTIVITY", for: .normal)
        }
        workerCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if myTimer != nil {
            myTimer?.invalidate()
            myTimer = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let newSiteName: String = Act.newSite()
        if newSiteName != "" {
            
            let curAct: String = Act.current()
          
            if ItemMaker.findSite(name: newSiteName) == nil {
                let newSite: Site = Sql.new(entity: "Site") as! Site
                newSite.name = newSiteName
                newSite.bossId = ""
                Sql.save()
            }
            
            if(curAct != ""){
                saveStamp(c: "")
                commentPop()
                if(curAct == newSiteName){
                    Act.current(val: "")
                }
                else{
                    Act.current(val: newSiteName)
                    Act.startTime(val: Date())
                }
            }
            else{
                Act.current(val: newSiteName)
                Act.startTime(val: Date())
            }
            Act.newSite(val: "")
        }
        setUp()
    }
    
    func commentPop(){
        let popComment = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentVC") as! CommentViewController
        self.addChildViewController(popComment)
        popComment.view.frame = (self.view.frame)
        self.view.addSubview(popComment.view)
        popComment.didMove(toParentViewController: self)
    }
    
    func saveStamp(c: String){
        newStamp = Sql.new(entity: "Stamp") as? Stamp
        newStamp?.comment = c
        newStamp?.uploaded = false
        newStamp?.siteName = curSite?.name
        newStamp?.startTime = Act.startTime() as? NSDate
        newStamp?.endTime = Date() as NSDate?
        newStamp?.workerId = Profile.userID()
        newStamp?.site = curSite
        Sql.save()
    }
    
    func updateStamp(c: String){
        newStamp?.comment = c
        Sql.save()
        newStamp = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func startCount(){
        if myTimer == nil {
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(donuh), userInfo: nil, repeats: true)
        }
    }
    
    func donuh() {
        let curStartDate: Date = (UserDefaults.standard.object(forKey: "currentStartTime") as? Date)!
        var comp = Calendar.current.dateComponents([.hour, .minute, .second], from: curStartDate, to: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        print("hours = \(comp.hour!):\(comp.minute!):\(comp.second!)")
        topCel?.started.text = formatter.string(from: curStartDate)
        topCel?.worked.text = "\(comp.hour!):\(comp.minute!):\(comp.second!)"
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "siteCell", for: indexPath) as! WorkerSiteCollectionViewCell
        let curAct: String = Act.current()
        cel.siteContent.isHidden = false
        cel.siteContentThree.isHidden = true
        cel.siteContentTwo.isHidden = true
        cel.layer.cornerRadius = 6
        cel.cellHeader.backgroundColor = UIColor.white
        cel.activityBall.backgroundColor = UIColor.red
        cel.cellLabel.textColor = UIColor.orange
        
        if(itemArray[indexPath.item].type == 0){
            cel.cellHeader.backgroundColor = UIColor.green
            cel.activityBall.backgroundColor = UIColor.green
            cel.cellLabel.textColor = UIColor.white
            cel.siteContent.isHidden = true
            cel.siteContentTwo.isHidden = false
            cel.cellLabel.text = "YOUR DAY TODAY"
            cel.topProjectTitle.text = curAct
            startCount()
            cel.endSessionButton.addTarget(self, action:#selector(endSess), for: .touchUpInside)
            cel.endSessionButton.layer.cornerRadius = 4
            topCel = cel
        }
        else if(itemArray[indexPath.item].type == 1){
            cel.cellLabel.text = itemArray[indexPath.item].model?.name
            cel.activityBall.layer.cornerRadius = 8
            cel.deleteButton.addTarget(self, action:#selector(deleteCell), for: .touchUpInside)
            cel.moreInfoButton.addTarget(self, action:#selector(moreInfo), for: .touchUpInside)
            if(curAct == itemArray[indexPath.item].model?.name){
                cel.activityBall.backgroundColor = UIColor.green
            }
            let tPro = itemArray[indexPath.item].model?.stamps?.count
            if(tPro! > 0){
                let stamps = ItemMaker.toStamps(stamps: (itemArray[indexPath.item].model?.stamps)!)
                let lastStamp = stamps[0]
                cel.yesterdayTotal.text = MyDate.format(date: lastStamp.startTime as! Date)
                cel.weekTotal.text = MyDate.format(date: lastStamp.endTime as! Date)
                cel.monthTotal.text = MyDate.between(from: lastStamp.startTime as! Date, to: lastStamp.endTime as! Date)
            }
            else{
                cel.yesterdayTotal.text = "00:00"
                cel.weekTotal.text = "00:00"
                cel.monthTotal.text = "0h 0m"
            }
            cel.projectTotal.text = "There are \(tPro!) records in this project"
            cel.deleteButton.layer.cornerRadius = 4
            cel.moreInfoButton.layer.cornerRadius = 4
        }
        else{
            cel.siteContent.isHidden = true
            cel.siteContentThree.isHidden = false
            cel.cellHeader.backgroundColor = UIColor.orange
            cel.activityBall.backgroundColor = UIColor.orange
            cel.cellLabel.textColor = UIColor.white
            cel.cellLabel.text = "TOTAL"
            let allstamps = ItemMaker.getStamps()
            var hours = 0
            var mins = 0
            for stamp in allstamps {
                hours = hours + MyDate.getHour(from: stamp.startTime as! Date, to: stamp.endTime as! Date)
                mins = mins + MyDate.getMin(from: stamp.startTime as! Date, to: stamp.endTime as! Date)
            }
            hours = hours + mins / 60
            mins = mins % 60
            cel.Tyester.text = "\(hours)h \(mins)m"
            cel.Tweek.text = "\(hours)h \(mins)m"
            cel.Tmonth.text = "\(hours)h \(mins)m"
        }
        return cel
    }
    
    func moreInfo() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let toController = storyBoard.instantiateViewController(withIdentifier: "WorkerHistoryVC") as! WorkerHistoryViewController
        self.present(toController, animated:true, completion:nil)
    }
    
    func endSess() {
        saveStamp(c: "This shift was ended by the worker himself")
        Act.current(val: "")
        setUp()
    }
    
    func deleteCell() {
        /*
        Sql.delete(obj: itemArray[selectedIndexPath!.item].model!)
        Sql.save()
        itemArray.remove(at: (selectedIndexPath!.item))
        workerCollectionView.deleteItems(at: [selectedIndexPath!])
        selectedIndexPath = nil
        workerCollectionView.performBatchUpdates(nil, completion: nil)*/
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 310, height: 110)
        if selectedIndexPath == indexPath {
            if(itemArray[indexPath.item].type == 0){
                size.height = 160
            }
            else if(itemArray[indexPath.item].type == 2){
                return size
            }
            else{
                size.height = 220
            }
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(selectedIndexPath == indexPath){
            selectedIndexPath = nil
        }
        else{
           selectedIndexPath = indexPath
        }
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        Profile.logout()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let toController = storyBoard.instantiateViewController(withIdentifier: "StartVC") as! StartViewController
        self.present(toController, animated:true, completion:nil)
    }
    
   
    @IBAction func export(_ sender: Any) {
        let popExport = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExportVC") as! ExportViewController
        self.addChildViewController(popExport)
        popExport.view.frame = (self.view.frame)
        self.view.addSubview(popExport.view)
        popExport.didMove(toParentViewController: self)
    }
    
    
    @IBAction func bringMenu(_ sender: Any) {
        
        if(menuShowing){
            sideMenuConstraint.constant = -200
            menuShowing = false
        }
        else{
            sideMenuConstraint.constant = 0
            menuShowing = true
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
}
