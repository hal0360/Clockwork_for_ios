//
//  WorkerHistoryViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 13/03/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WorkerHistoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var actionBar: UIView!
    @IBOutlet weak var StampCollectionView: UICollectionView!
    @IBOutlet weak var timeSelView: UIView!
    @IBOutlet weak var scrolView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var exportCSVbutton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var upgradeButton: UIView!
    
    @IBOutlet weak var myTeamButton: UIView!
    
    var stampArray = Array<Stamp>()
    var selectedIndexPath: IndexPath? = nil
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuConstraint.constant = -200
        exportCSVbutton.layer.cornerRadius = 5
        timeSelView.layer.cornerRadius = 5
        scrolView.layer.cornerRadius = 5
        
        
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

    override func viewWillAppear(_ animated: Bool) {
        stampArray = ItemMaker.getStamps()
        var hours = 0
        var mins = 0
        for stamp in stampArray {
            hours = hours + MyDate.getHour(from: stamp.startTime as! Date, to: stamp.endTime as! Date)
            mins = mins + MyDate.getMin(from: stamp.startTime as! Date, to: stamp.endTime as! Date)
        }
        hours = hours + mins / 60
        mins = mins % 60
        totalLabel.text = "\(hours)h \(mins)m"
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stampArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "stampCell", for: indexPath) as! WorkerStampCollectionViewCell
      
        cel.SiteName.text = stampArray[indexPath.item].siteName
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        cel.commentDot.layer.cornerRadius = 5
        
        let comment = stampArray[indexPath.item].comment?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        cel.CommentText.text = comment
        cel.CommentText.isUserInteractionEnabled = false
        
        if(comment == ""){
            cel.commentDot.isHidden = true
        }
        else{
            cel.commentDot.isHidden = false
        }
     
        cel.StartTime.text = MyDate.format(date: stampArray[indexPath.item].startTime as! Date)
        cel.EndTime.text = MyDate.format(date: stampArray[indexPath.item].endTime as! Date)
        cel.TotalHourMin.text = MyDate.between(from: stampArray[indexPath.item].startTime as! Date, to: stampArray[indexPath.item].endTime as! Date)
        
        return cel
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 310, height: 30)
        if selectedIndexPath == indexPath {
            size.height = 100
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let comment = stampArray[indexPath.item].comment?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (comment == ""){
            return
        }
        
        if(selectedIndexPath == indexPath){
            selectedIndexPath = nil
        }
        else{
            selectedIndexPath = indexPath
        }
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    @IBAction func export(_ sender: Any) {
    }
    
    @IBAction func logout(_ sender: Any) {
        Profile.logout()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let toController = storyBoard.instantiateViewController(withIdentifier: "StartVC") as! StartViewController
        self.present(toController, animated:true, completion:nil)
    }

}
