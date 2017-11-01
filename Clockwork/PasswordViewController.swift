//
//  PasswordViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 30/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class PasswordViewController: RootViewController {

    @IBOutlet weak var mailField: UITextField!


    @IBAction func resetPass(_ sender: Any) {
        let usrEmail = mailField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let Etested  = emailTest.evaluate(with: usrEmail)
        
        if !Etested {
            Toast.show(contex: self, message: "Invalid email")
            return
        }
   
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
