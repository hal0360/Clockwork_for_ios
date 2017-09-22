//
//  WorkerSiteCollectionViewCell.swift
//  Clockwork
//
//  Created by Ron Lu on 6/03/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class WorkerSiteCollectionViewCell: UICollectionViewCell {
    
    //project
    @IBOutlet weak var cellHeader: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var activityBall: UIView!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var projectTotal: UILabel!
    @IBOutlet weak var yesterdayTotal: UILabel!
    @IBOutlet weak var weekTotal: UILabel!
    @IBOutlet weak var monthTotal: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var siteContent: UIView!
    
    
    //top
    @IBOutlet weak var siteContentTwo: UIView!
    @IBOutlet weak var topProjectTitle: UILabel!
    @IBOutlet weak var started: UILabel!
    @IBOutlet weak var worked: UILabel!
    @IBOutlet weak var endSessionButton: UIButton!
    
    
    //TOTAL
    @IBOutlet weak var siteContentThree: UIStackView!
    @IBOutlet weak var Tyester: UILabel!
    @IBOutlet weak var Tweek: UILabel!
    @IBOutlet weak var Tmonth: UILabel!
    
    
}
