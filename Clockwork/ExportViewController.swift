//
//  ExportViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 28/06/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class ExportViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var periodPicker: UIPickerView!
    @IBOutlet weak var projectPicker: UIPickerView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var userPicker: UIPickerView!
    
    let periods = ["ALL TIME", "THIS YEAR", "THIS MONTH", "THIS WEEK", "YESTERDAY"]
    var projects = ["ALL PROJECTS"]
    var users = ["ALL USERS"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == periodPicker {
            return "\(periods[row])"
        }else if pickerView == projectPicker {
            return "\(projects[row])"
        }else {
            return "\(users[row])"
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == periodPicker {
            return periods.count
        }else if pickerView == projectPicker {
            return projects.count
        }else {
            return users.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //will do it later
    }
    

        
    override func viewDidLoad() {
        super.viewDidLoad()

        let sites = Sql.load(entity: "Site")
        for site in sites as! [Site]{
            projects.append(site.name!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    
    @IBAction func export(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
