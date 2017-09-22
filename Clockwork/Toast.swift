//
//  Toast.swift
//  Clockwork
//
//  Created by Ron Lu on 10/03/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import UIKit


class Toast{
    
    private init(){
        
    }
    
    class func alert(contex: UIViewController, mss: String){
        let alert = UIAlertController(title: "ERROR", message: mss, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        contex.present(alert, animated: true, completion: nil)
    }
    
    class func show(contex: UIViewController, message: String) {
        let toastLabel =
            UILabel(frame:
                CGRect(x: contex.view.frame.size.width/2 - 150,
                       y: contex.view.frame.size.height-100,
                       width: 300,
                       height: 35))
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = NSTextAlignment.center
        contex.view.addSubview(toastLabel)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIView.animate(withDuration: 5.0, animations: {
            toastLabel.alpha = 0.0
        })
        
        

    }

}
