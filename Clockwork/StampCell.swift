//
//  StampCell.swift
//  Clockwork
//
//  Created by Ron Lu on 27/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class StampCell: UICollectionViewCell {
    
    //header
    @IBOutlet weak var headerContent: UIView!
    @IBOutlet weak var headerDate: UILabel!
    @IBOutlet weak var headerTime: UILabel!
    
    //stamp
    @IBOutlet weak var stampContent: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var commentDot: UIView!
    
    
}
