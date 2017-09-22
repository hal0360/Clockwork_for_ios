//
//  StartViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 31/05/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit
import CoreData

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        Profile.role(val: 2)
 
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Profile.role() != 0{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let toController = storyBoard.instantiateViewController(withIdentifier: "WorkerHomeVC") as! WorkerHomeViewController
            self.present(toController, animated:false, completion:nil)
        }
        
        //  Toast.show(contex: self, message: "yes")
        
    }
    
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
