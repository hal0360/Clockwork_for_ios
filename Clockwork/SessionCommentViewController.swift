//
//  SessionCommentViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 31/10/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class SessionCommentViewController: RootViewController {

    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @IBAction func save(_ sender: Any) {
        let parentView = self.parent as! MainViewController
    
        parentView.updateStamp(c: comment.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
        // print(commentTextView.text)
        self.view.removeFromSuperview()
    }
}
