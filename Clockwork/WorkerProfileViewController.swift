//
//  WorkerProfileViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 28/06/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class WorkerProfileViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var actionBar: UIView!
    @IBOutlet weak var upgradeButton: UIView!
    
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var myTeamButton: UIView!
    var menuShowing = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuConstraint.constant  = -200
        
        
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
        companyLabel.text = "N/A"
        nameLabel.text = Profile.firstName() + " " + Profile.lastName()
        emailLabel.text = Profile.email()
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
    
    @IBAction func logout(_ sender: Any) {
        Profile.logout()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let toController = storyBoard.instantiateViewController(withIdentifier: "StartVC") as! StartViewController
        self.present(toController, animated:true, completion:nil)
    }

}
