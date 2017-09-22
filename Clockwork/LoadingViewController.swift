//
//  LoadingViewController.swift
//  Clockwork
//
//  Created by Ron Lu on 1/09/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit
import os.log
import Alamofire

class LoadingViewController: UIViewController {
    
    var request: Request? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        request = Request(contex: self, blocked: false)
        startData()
        
    }
    
    func startData(){
    
        let stuffStamps = Sql.load(entity: "Stamp") as! Array<Stamp>
        var shift: Shift
        var shifts = Array<Shift>()
        
        for stamp in stuffStamps {
            if !stamp.uploaded{
                shift = Shift()
                shift.qrCodeIdentifier = stamp.siteName
                shift.userId = stamp.workerId
                shift.shiftTimeEndOnUtc = MyDate.dateToStr(date: stamp.endTime!)
                shift.shiftTimeStartOnUtc = MyDate.dateToStr(date: stamp.startTime!)
                shift.comment = stamp.comment
                shifts.append(shift)
            }
        }
        for stamp in stuffStamps {
           Sql.delete(obj: stamp)
        }
        
        
        request?.post(url: "https://clockwork-api.azurewebsites.net/v1/projects/shifts/save/", json: shifts.toJsonString(), auth: Profile.token()) { response in
            
            let code = response.response?.statusCode
            
            if(code == 204){
                
            }
            else{
                print(code!)
                os_log("failed to push shifts to server on load", type: .error)
            }
            self.getProjects()
            
        }
       
    }
    
    func getProjects(){
        

        let headers = ["Authorization": "Basic \(Profile.token())"]
        Alamofire.request("https://clockwork-api.azurewebsites.net/v1/projects",
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers:headers)
            .validate()
        .responseString { (response) in
            let code = response.response?.statusCode
            
            if(code == 200){
                
                let myjson = response.result.value
                let projects = [Project](json: myjson)
        
                
                var site: Site
                for project in projects{
                    site = Sql.new(entity: "Site") as! Site
                    site.name = project.qrCodeIdentifier
                    site.bossId = project.businessId
                    
                }
                Sql.save()
                
            }
            else{
                print(code!)
                os_log("failed get projects from server", type: .error)
            }
            self.getShifts()
        }
        
        
        /*
        request?.get(url: "https://clockwork-api.azurewebsites.net/v1/projects/", auth: Profile.token()) { response in
            
            let code = response.response?.statusCode
            
            if(code == 200){
                
                let myjson = response.result.value
                let projects = [Project](json: myjson)
                
                var site: Site
                for project in projects{
                    site = Sql.new(entity: "Site") as! Site
                    site.name = project.qrCodeIdentifier
                    site.bossId = project.businessId
                    Sql.save()
                }
                
            }
            else{
                print(code!)
                os_log("failed get projects from server", type: .error)
            }
            self.getShifts()
        }*/

    }
    
    func getShifts(){
        
        
        let getShinfo = GetShiftInfo()
        
        let headers = ["Authorization": "Basic \(Profile.token())"]
        Alamofire.request("https://clockwork-api.azurewebsites.net/v1/projects/shifts",
                          method: .post,
                          parameters: getShinfo.toDictionary() as? Parameters,
                          encoding: URLEncoding.default,
                          headers:headers)
            .validate()
            .responseString { (response) in
                let code = response.response?.statusCode
                
                if(code == 200){
                    
                    let myjson = response.result.value
                    let shifts = [Shift](json: myjson)
                    
                    var stamp: Stamp
                    for shift in shifts{
                        stamp = Sql.new(entity: "Stamp") as! Stamp
                        stamp.comment = shift.comment
                        stamp.endTime = Date() as NSDate?
                        stamp.startTime = Date() as NSDate?
                        stamp.siteName = shift.qrCodeIdentifier
                        stamp.stopped = false
                        stamp.uploaded = true
                        
                    }
                    Sql.save()
                    
                }
                else{
                    print(code!)
                    os_log("failed get shifts from server", type: .error)
                }
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let toController = storyBoard.instantiateViewController(withIdentifier: "WorkerHomeVC") as! WorkerHomeViewController
                self.present(toController, animated:true, completion:nil)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
