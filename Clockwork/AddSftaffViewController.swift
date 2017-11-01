//
//  AddSftaffViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 16/09/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit

class AddSftaffViewController: RootViewController {

    @IBOutlet weak var qrImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        qrImage.image = generateQRCode(from: Profile.userID())
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

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
