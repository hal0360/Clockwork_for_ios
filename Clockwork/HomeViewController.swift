//
//  HomeViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 24/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: NaviViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var projectCollectionView: UICollectionView!
    @IBOutlet weak var activityButton: UIButton!
    var itemArray = Array<Item>()
    var selectedIndexPath: IndexPath? = nil
    var myTimer: Timer? = nil
    var curSite: Site? = nil
    
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
        projectCollectionView.reloadData()
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
                mainVC?.saveStamp(c: "", site: curSite!)
                Kit.pop(contex: mainVC!, id: "CommentVC")
                
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectCell
        if(itemArray[indexPath.item].type == 0){
            cel.setTop()
            cel.endSessionButton.addTarget(self, action:#selector(endSess), for: .touchUpInside)
            myTimer = cel.myTimer
        }
        else if(itemArray[indexPath.item].type == 1){
            cel.setProject(site: itemArray[indexPath.item].model!)
            cel.deleteButton.addTarget(self, action:#selector(deleteCell), for: .touchUpInside)
            cel.moreInfoButton.addTarget(self, action:#selector(moreInfo), for: .touchUpInside)
        }
        else{
            cel.setTotal()
        }
        return cel
    }
    
    func moreInfo() {
        mainVC?.toHistory()
    }
    
    func endSess() {
        mainVC?.saveStamp(c: "", site: curSite!)
        Kit.pop(contex: mainVC!, id: "SessionCommentVC")
       // saveStamp(c: "This shift was ended by the worker himself")
        Act.current(val: "")
        setUp()
    }
    
    func deleteCell() {
        let name = itemArray[selectedIndexPath!.item].model?.name
        let alert = UIAlertController(title: "Deleting \(name)", message: "Are you sure you want to delete this project?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.itemArray.remove(at: (self.selectedIndexPath!.item))
            self.projectCollectionView.deleteItems(at: [self.selectedIndexPath!])
            self.selectedIndexPath = nil
            self.projectCollectionView.performBatchUpdates(nil, completion: nil)
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
             alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
        /*
         Sql.delete(obj: itemArray[selectedIndexPath!.item].model!)
         Sql.save()*/
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

}
