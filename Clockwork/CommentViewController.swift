//
//  CommentViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 11/03/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class CommentViewController: RootViewController {

    @IBOutlet weak var commentLabelTitle: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        commentLabelTitle.text = "Check out from: " + Act.current()
    }

    
    @IBAction func saveComment(_ sender: Any) {
        
        
        let parentView = self.parent as! MainViewController
 
        parentView.updateStamp(c: commentTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
       // print(commentTextView.text)
        self.view.removeFromSuperview()
        
        
    }
    
}
