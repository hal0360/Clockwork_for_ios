//
//  ScannerViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 6/03/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController , AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        captureSession.startRunning();
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (captureSession?.isRunning == false) {
            captureSession.startRunning();
        }
        
        let button = UIButton(frame: CGRect(x: self.view.frame.size.width/2 - 80, y: self.view.frame.size.height-70, width: 160, height: 40))
       // button.backgroundColor = .green
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.setTitle("CANCEL", for: .normal)
        button.addTarget(self, action: #selector(canceling), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func canceling(sender: UIButton!) {
        Temp.QRcode = ""
        Act.newSite(val: "")
        captureSession.stopRunning()
        dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning();
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            let gotit: String = readableObject.stringValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            Act.newSite(val: gotit)
            Temp.QRcode = gotit
        }
        else{
            Act.newSite(val: "")
            Temp.QRcode = ""
        }
        dismiss(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
