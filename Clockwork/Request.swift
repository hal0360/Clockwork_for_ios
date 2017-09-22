//
//  Request.swift
//  Clockwork
//
//  Created by Ron Lu on 23/06/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import Alamofire

class Request{
    
    var alertController: UIAlertController
    var contex: UIViewController
    var blocked: Bool
    
    
    
    struct JSONStringArrayEncoding: ParameterEncoding {
        private let myString: String
        
        init(string: String) {
            self.myString = string
        }
        
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var urlRequest = urlRequest.urlRequest
            
            let data = myString.data(using: .utf8)!
            
            if urlRequest?.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest?.httpBody = data
            
            return urlRequest!
        }}
    
    
    
    
    init(contex: UIViewController, blocked: Bool){
        self.contex = contex
        self.blocked = blocked
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
    }
    
    func post(url: String, json: String, auth: String?, callback: @escaping (_ response: DataResponse<String>) -> ()){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if(auth != nil){
            request.setValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
        }
        let data = (json.data(using: .utf8))! as Data
        request.httpBody = data
        
        if blocked{
          contex.present(alertController, animated: false, completion: nil)
        }
        
        
        Alamofire.request(request).responseString { (response) in
            if self.blocked{
               self.alertController.dismiss(animated: true, completion: nil)
            }
            callback(response)
            
        }
        
        
        
        //Alamofire.request("your url string", method: .post, parameters: [:], encoding: JSONStringArrayEncoding.init(string: "My string for body"), headers: [:])
        
        
    }
    
    func get(url: String, auth: String?, callback: @escaping (_ response: DataResponse<String>) -> ()){
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        if(auth != nil){
            request.setValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
        }
        if blocked{
            contex.present(alertController, animated: false, completion: nil)
        }
        Alamofire.request(request).responseString { (response) in
            if self.blocked{
                self.alertController.dismiss(animated: true, completion: nil)
            }
            callback(response)
        }
    }
}
