//
//  MainViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 24/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class MainViewController: RootViewController {

    @IBOutlet weak var sideMenu: UIView!
    var container: ContainerViewController!
    var menuShowing = false
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var myTeamButton: UIView!
    @IBOutlet weak var actionBar: UIView!
    @IBOutlet weak var upgradeButton: UIView!
    @IBOutlet weak var pageTitle: UILabel!
    var newStamp: Stamp? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sideMenuConstraint.constant = -200
        menuShowing = false
        if Profile.role() == 1{
            actionBar.backgroundColor = .orange
            sideMenu.backgroundColor = .orange
            myTeamButton.isHidden = true
            upgradeButton.isHidden = false
            
        }else{
            actionBar.backgroundColor =  UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
            sideMenu.backgroundColor =  UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
            myTeamButton.isHidden = false
            upgradeButton.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            container = segue.destination as! ContainerViewController
            container.mainVC = self
            pageTitle.text = "HOME"
            container.segueIdentifierReceivedFromParent("home")
        }
    }
    
    func saveStamp(c: String, site: Site){
        newStamp = Sql.new(entity: "Stamp") as? Stamp
        newStamp?.comment = c
        newStamp?.uploaded = false
        newStamp?.siteName = site.name
        newStamp?.startTime = Act.startTime() as? NSDate
        newStamp?.endTime = Date() as NSDate?
        newStamp?.workerId = Profile.userID()
        newStamp?.site = site
        Sql.save()
    }
    
    func updateStamp(c: String){
        newStamp?.comment = c
        Sql.save()
        newStamp = nil
    }
    
    @IBAction func menu(_ sender: Any) {
        menuTrigger()
    }
    
    func menuTrigger(){
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
    
    @IBAction func home(_ sender: Any) {
        container.segueIdentifierReceivedFromParent("home")
        menuTrigger()
        pageTitle.text = "HOME"
    }
    
    func toHistory(){
        container.segueIdentifierReceivedFromParent("history")
        menuTrigger()
        pageTitle.text = "HISTORY"
    }
    
    @IBAction func history(_ sender: Any) {
        toHistory()
    }
    
    @IBAction func profile(_ sender: Any) {
        container.segueIdentifierReceivedFromParent("profile")
        menuTrigger()
        pageTitle.text = "PROFILE"
    }
    
    @IBAction func export(_ sender: Any) {
        Kit.pop(contex: self, id: "ExportVC")
    }
    
    @IBAction func myTeam(_ sender: Any) {
        container.segueIdentifierReceivedFromParent("myTeam")
        menuTrigger()
        pageTitle.text = "MY TEAM"
    }
    
    @IBAction func setting(_ sender: Any) {
        container.segueIdentifierReceivedFromParent("setting")
        menuTrigger()
        pageTitle.text = "SETTINGS"
    }
    
    @IBAction func upgrade(_ sender: Any) {
    }
   
    @IBAction func logout(_ sender: Any) {
        Profile.logout()
        Kit.goTo(contex: self, id: "SignInVC")
    }
    
}
