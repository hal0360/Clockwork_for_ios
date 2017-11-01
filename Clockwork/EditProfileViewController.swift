//
//  EditProfileViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 21/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class EditProfileViewController: RootViewController {
    
    @IBOutlet weak var actionBar: UIView!
    @IBOutlet weak var editFName: UITextField!
    @IBOutlet weak var editLName: UITextField!
    @IBOutlet weak var editEmail: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if Profile.role() == 1{
            actionBar.backgroundColor = .orange
        }else{
            actionBar.backgroundColor =  UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
        }
        
        editEmail.placeholder = Profile.email()
        editFName.placeholder = Profile.firstName()
        editLName.placeholder = Profile.lastName()
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func save(_ sender: Any) {
    }
    
}
