//
//  MyTeamViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 11/09/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class MyTeamViewController: UIViewController {


    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuConstraint.constant  = -200
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
