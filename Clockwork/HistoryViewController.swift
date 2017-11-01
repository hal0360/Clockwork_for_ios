//
//  HistoryViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 24/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class HistoryViewController: NaviViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var StampCollectionView: UICollectionView!
    @IBOutlet weak var totalTime: UILabel!
    var stampItems = Array<StampItem>()
    var selectedIndexPath: IndexPath? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        stampItems = ItemMaker.getStampItems()
        var hours = 0
        var mins = 0
        for stampItem in stampItems {
            if stampItem.type == 1{
                hours = hours + MyDate.getHour(from: stampItem.model!.startTime as! Date, to: stampItem.model!.endTime as! Date)
                mins = mins + MyDate.getMin(from: stampItem.model!.startTime as! Date, to: stampItem.model!.endTime as! Date)
            }
        }
        hours = hours + mins / 60
        mins = mins % 60
        totalTime.text = "\(hours)h \(mins)m"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stampItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "stampCell", for: indexPath) as! StampCell
        
        if(stampItems[indexPath.item].type == 0){
            cel.headerContent.isHidden = false
            cel.stampContent.isHidden = true
            cel.headerDate.text = stampItems[indexPath.item].date
            cel.headerTime.text = stampItems[indexPath.item].total
        }
        else{
            cel.headerContent.isHidden = true
            cel.stampContent.isHidden = false
            cel.name.text = stampItems[indexPath.item].model?.siteName
            cel.commentDot.layer.cornerRadius = 5
            cel.comment.text = stampItems[indexPath.item].model?.comment
            cel.comment.isUserInteractionEnabled = false
            if(cel.comment.text == ""){
                cel.commentDot.isHidden = true
            }
            else{
                cel.commentDot.isHidden = false
            }
            cel.startTime.text = MyDate.format(date: stampItems[indexPath.item].model?.startTime as! Date)
            cel.endTime.text = MyDate.format(date: stampItems[indexPath.item].model?.endTime as! Date)
            cel.totalTime.text = MyDate.between(from: stampItems[indexPath.item].model?.startTime as! Date, to: stampItems[indexPath.item].model?.endTime as! Date)
        }
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
        
        if stampItems[indexPath.item].type == 0 {
            return
        }
        else{
            if stampItems[indexPath.item].model?.comment == "" {
                return
            }
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
        Kit.pop(contex: mainVC!, id: "ExportVC")
    }

}
