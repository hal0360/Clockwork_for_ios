//
//  ProfileViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 27/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class ProfileViewController: NaviViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emaiLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var panel: UIView!
    @IBOutlet weak var NotiCollectionView: UICollectionView!
    var notices = Array<Notice>()
    
    override func viewWillAppear(_ animated: Bool) {
        if Profile.role() == 1{
            panel.backgroundColor = UIColor(red: 255/255, green: 146/255, blue: 82/255, alpha: 1)
        }else{
            panel.backgroundColor =  UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 1)
        }
        companyLabel.text = Profile.company()
        nameLabel.text = Profile.firstName() + " " + Profile.lastName()
        emaiLabel.text = Profile.email()
        notices = Sql.load(entity: "Notice") as! Array<Notice>
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "notificationCell", for: indexPath) as! NotificationCell
        
        return cel
    }
}
