//
//  MyTeamViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 11/09/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class MyTeamViewController: NaviViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var userCollectionView: UICollectionView!
    var workers = Array<Worker>()
    var selectedIndexPath: IndexPath? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        workers = Sql.load(entity: "Worker") as! Array<Worker>
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! UserCell
        
        //to do
        
        return cel
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 310, height: 110)
        if selectedIndexPath == indexPath {
            size.height = 220
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
