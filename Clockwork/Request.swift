//
//  Request.swift
//  Clockwork
//
//  Created by Ron Lu on 23/06/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import Alamofire


extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}


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
        }
    }
    
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
    
    func post(url: String, json: String, auth: String, callback: @escaping (_ response: DataResponse<String>) -> ()){
        var headers = ["Content-Type": "application/json"]
        
        if(auth != ""){
            headers = ["Content-Type": "application/json", "Authorization": "Basic \(auth)"]
        }
       
        
        if blocked{
            contex.present(alertController, animated: false, completion: nil)
        }
        

        Alamofire.request(url, method: .post, parameters: [:], encoding: json, headers: headers).responseString { (response) in
            if self.blocked{
                self.alertController.dismiss(animated: true, completion: nil)
            }
            callback(response)
        }

    }
    
    
    func get(url: String, auth: String, callback: @escaping (_ response: DataResponse<String>) -> ()){
        var headers = ["Content-Type": "application/json"]
        
        if(auth != ""){
            headers = ["Content-Type": "application/json", "Authorization": "Basic \(auth)"]
        }
        
        if blocked{
            contex.present(alertController, animated: false, completion: nil)
        }
        
        Alamofire.request(url, method: .get, headers: headers).responseString { (response) in
            if self.blocked{
                self.alertController.dismiss(animated: true, completion: nil)
            }
            callback(response)
        }
        
    }
    
}
