//
//  AddSftaffViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 16/09/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class AddSftaffViewController: UIViewController {

    
    @IBOutlet weak var qrImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        qrImage.image = generateQRCode(from: Profile.userID())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }


}
