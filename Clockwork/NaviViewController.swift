//
//  NaviViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 29/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class NaviViewController: RootViewController {

    var mainVC : MainViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let containView = self.parent as! ContainerViewController
        mainVC = containView.mainVC
    }

}
