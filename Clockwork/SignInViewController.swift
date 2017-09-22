//
//  SignInViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 29/06/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInForm: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        signInForm.layer.borderWidth = 1
        signInForm.layer.borderColor = UIColor.white.cgColor
         signInForm.layer.cornerRadius = 6
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        mailField.attributedPlaceholder = NSAttributedString(string: mailField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        passField.attributedPlaceholder = NSAttributedString(string: passField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white])
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(_ sender: Any) {
        
        let usrEmail = mailField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let usrPass = passField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let Etested  = emailTest.evaluate(with: usrEmail)
        
        if !Etested {
            Toast.show(contex: self, message: "Invalid email")
            return
        }
        if usrPass == "" {
            Toast.show(contex: self, message: "Password must not be empty")
            return
        }
        
        Profile.email(val: usrEmail)
        
        let logInfo: LoginInfo = LoginInfo(fName: "", lName: "", mail: usrEmail, pass: usrPass)
       
        let request = Request(contex: self, blocked: true)
        request.post(url: "https://clockwork-api.azurewebsites.net/v1/authentication/login", json: logInfo.toJsonString(), auth: nil) { response in
            
            let code = response.response?.statusCode
            
            if(code == 200){
                Toast.show(contex: self, message: "Login succesful")
                let myjson = response.result.value
                let userr: LoginResult = LoginResult(json: myjson!)
                
                Profile.token(val: userr.apiToken)
                Profile.firstName(val: userr.firstName)
                Profile.lastName(val: userr.lastName)
                Profile.userID(val: userr.userId)
                Profile.role(val: userr.userRoleId + 1)
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let toController = storyBoard.instantiateViewController(withIdentifier: "LoadingVC") as! LoadingViewController
                self.present(toController, animated:true, completion:nil)
            }
            else if (code == 404){
                Toast.show(contex: self, message: "Error: email not found")
            }
            else if (code == 401){
                Toast.show(contex: self, message: "Error: password not correct")
            }
            else{
                Toast.show(contex: self, message: "Bad connection")
            }
        }
        
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
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
}
