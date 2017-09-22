//
//  Sql.swift
//  Clockwork
//
//  Created by Ron Lu on 28/06/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation
import CoreData
import os.log

class Sql {
    
    private init(){}
    
    class func load(entity : String) -> [Any]{
        var results = [Any]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do{
            results = try getContex().fetch(fetchRequest)
        }
        catch{
            os_log("failed to from coredata", type: .error)
        }
        return results
    }
    
    class func new(entity: String) -> NSManagedObject{
        return NSEntityDescription.insertNewObject(forEntityName: entity, into: getContex())
    }
    
    class func delete(obj: NSManagedObject){
        getContex().delete(obj)
        save()
    }
    
    
    class func getContex() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    //class func getContex() -> NSManagedObjectContext {
    //    return DatabaseController.persistentContainer.viewContext
   // }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                os_log("Unresolved error", type: .error)
                
                //fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    class func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                os_log("failed to save coredata context", type: .error)
            }
        }
    }
    
    
}
