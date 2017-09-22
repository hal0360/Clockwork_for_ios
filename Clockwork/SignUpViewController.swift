//
//  SignUpViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 29/05/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var SignUpForm: UIView!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    @IBOutlet weak var userTwoField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        SignUpForm.layer.borderWidth = 1
        SignUpForm.layer.borderColor = UIColor.white.cgColor
        SignUpForm.layer.cornerRadius = 6
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        userField.attributedPlaceholder = NSAttributedString(string: userField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        userTwoField.attributedPlaceholder = NSAttributedString(string: userField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        emailField.attributedPlaceholder = NSAttributedString(string: emailField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        passField.attributedPlaceholder = NSAttributedString(string: passField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        confirmPassField.attributedPlaceholder = NSAttributedString(string: confirmPassField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @IBAction func submitForm(_ sender: UIButton) {
        
        let usrName = userField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let usrTwoName = userTwoField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let usrEmail = emailField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let usrPass = passField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let usrPassCon = confirmPassField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let Etested  = emailTest.evaluate(with: usrEmail)
        
        if usrName == "" {
            Toast.show(contex: self, message: "First name must not be empty")
            return
        }
        if usrTwoName == "" {
            Toast.show(contex: self, message: "Last name must not be empty")
            return
        }
        if !Etested {
            Toast.show(contex: self, message: "Invalid email")
            return
        }
        if usrPass == "" {
            Toast.show(contex: self, message: "Password must not be empty")
            return
        }
        if usrPass != usrPassCon {
            Toast.show(contex: self, message: "Password not match")
            return
        }
        
    
         let loginInfo: LoginInfo = LoginInfo(fName: usrName, lName: usrTwoName, mail: usrEmail, pass: usrPass)
        let request = Request(contex: self, blocked: true)
         request.post(url: "https://clockwork-api.azurewebsites.net/v1/authentication/create", json: loginInfo.toJsonString(), auth: nil) { response in
         
           let code = response.response?.statusCode
         
           if(code == 204){
             Toast.show(contex: self, message: "Login succesful")
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let toController = storyBoard.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
            self.present(toController, animated:true, completion:nil)
            
           }
           else if (code == 400){
             Toast.show(contex: self, message: "Error: email already existed")
           }
           else{
             Toast.show(contex: self, message: "Bad connection")
           }
         }
    }
    
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
