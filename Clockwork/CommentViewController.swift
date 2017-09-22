//
//  CommentViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 11/03/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    
    @IBOutlet weak var commentLabelTitle: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentLabelTitle.text = "Check out from: " + Act.current()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveComment(_ sender: Any) {
        
        
        let parentView = self.parent as! WorkerHomeViewController
 
        parentView.updateStamp(c: commentTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
       // print(commentTextView.text)
        self.view.removeFromSuperview()
        
        
    }
    
}
