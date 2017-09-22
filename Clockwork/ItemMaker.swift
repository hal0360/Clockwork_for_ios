//
//  ItemMaker.swift
//  Clockwork
//
//  Created by Ron Lu on 25/06/17.
//  Copyright © 2017 Udenconstruction. All rights reserved.
//

import Foundation

class ItemMaker{
    private init(){}
    
    class func getSites() -> Array<Site>{
        /*let myFetch: NSFetchRequest<Site> = Site.fetchRequest()
        do{
            let sites = try DatabaseController.getContex().fetch(myFetch)
            for site in sites as [Site]{
                siteArray.append(site)
            }
        }
        catch{
            print("cannot fecth sites")
        }*/
        return Sql.load(entity: "Site") as! [Site]
    }
    
    class func findSite(name: String) -> Site?{
        let sites = Sql.load(entity: "Site")
        for site in sites as! [Site]{
            if(name == site.name){
                return site
            }
        }
        return nil
    }
    
    class func getSiteItems() -> Array<Item>{
        var item: Item
        var itemArray = Array<Item>()
        let sites = Sql.load(entity: "Site")
        for site in sites as! [Site]{
            item = Item(type: 1)
            item.model = site
            itemArray.append(item)
        }
        item = Item(type: 2)
        itemArray.append(item)
        return itemArray
    }
    
    class func getStamps() -> Array<Stamp>{
        let stuffStamps = Sql.load(entity: "Stamp") as! Array<Stamp>
        return stuffStamps.sorted(by: { $0.startTime?.compare($1.startTime as! Date) == .orderedDescending})
    }
    
    class func toStamps(stamps: NSSet) -> Array<Stamp>{
        let newstamps = Array(stamps as! Set<Stamp>)
        return newstamps.sorted(by: { $0.startTime?.compare($1.startTime as! Date) == .orderedDescending})
    }
}

