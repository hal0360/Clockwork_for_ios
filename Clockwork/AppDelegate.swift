//
//  AppDelegate.swift
//  Clockwork
//
//  Created by Ron Lu on 27/02/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
      //  UserDefaults.standard.register(defaults: ["currentActivity" : ""])
        UserDefaults.standard.register(defaults: ["startTime" : Date()])
        
        /*
        let newSiteEntity: StaffSiteModel = NSEntityDescription.insertNewObject(forEntityName: "StaffSiteModel", into: DatabaseController.getContex()) as! StaffSiteModel
        newSiteEntity.name = "office"
        newSiteEntity.token = "blah"
        DatabaseController.saveContext()
         
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
         self.siteArray.insert(self.scannedSIte!, at: 0)
         self.workerCollectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
         }
         
         
         let popLast = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LastSeenVC") as! LastSeenViewController
         
         self.parent?.parent?.addChildViewController(popLast)
         popLast.view.frame = (self.parent?.parent?.view.frame)!
         self.parent?.parent?.view.addSubview(popLast.view)
         popLast.didMove(toParentViewController: self.parent?.parent)
         
         
         */
        
        //  let date = Date()
        // let formatter = DateFormatter()
        //  formatter.dateFormat = "HH:mm"
        // let resultdt = formatter.string(from: date)
        // print(resultdt)
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        
        //Profile.role(val: 1)
        
        if Profile.role() != 0{
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainVC")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
        /*        var newSite: Site
         let myFetch: NSFetchRequest<StaffSiteModel> = StaffSiteModel.fetchRequest()
         do{
         let stuffSites = try DatabaseController.getContex().fetch(myFetch)
         for stuffSite in stuffSites as [StaffSiteModel]{
         newSite = Site()
         newSite.model = stuffSite
         siteArray.append(newSite)
         siteModels.append(stuffSite)
         }
         }
         catch{
         print("cannot fecth sites")
         }
         
         
         let myyFetch: NSFetchRequest<StaffWorkStampModel> = StaffWorkStampModel.fetchRequest()
         do{
         let stuffStamps = try DatabaseController.getContex().fetch(myyFetch)
         for stuffStamp in stuffStamps as [StaffWorkStampModel]{
         print(stuffStamp.comment ?? "not found")
         
         let formatter = DateFormatter()
         formatter.dateFormat = "HH:mm"
         
         print(formatter.string(from: stuffStamp.startTime as! Date))
         print(formatter.string(from: stuffStamp.endTime as! Date))
         }
         }
         catch{
         print("cannot fecth stamps")
         }*/
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

