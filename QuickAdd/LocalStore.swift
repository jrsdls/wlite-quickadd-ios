//
//  LocalStore.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/22/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation
import CoreData

class LocalStore {
    
    class var lists : [MOList]? {
        get {
            if let moc = App.delegate.managedObjectContext {
                let request = NSFetchRequest(entityName: "List")
                if let results = moc.executeFetchRequest(request, error: nil) {
                    var lists = [MOList]()
                    for object in results {
                        let molist = object as! MOList
                        lists.append(molist)
                    }
                    return (lists.count > 0 ? lists : nil)
                }
            }
            return nil
        }
        set {
            if let lists = newValue {
                if let moc = App.delegate.managedObjectContext {
                    for list in lists {
                        var request = NSFetchRequest(entityName: "List")
                        request.predicate = NSPredicate(format: "id = %i", list.id)
                        if let results = moc.executeFetchRequest(request, error: nil){
                            var mo:MOList! = nil
                            if(results.isEmpty){
                                mo = NSEntityDescription.insertNewObjectForEntityForName("List", inManagedObjectContext: moc) as! MOList
                            }
                            else {
                                mo = results.first as! MOList
                            }
                            mo.id = list.id
                            mo.revision = list.revision
                            mo.title = list.title
                            mo.listType = list.listType
                            mo.lastUsedDate = list.lastUsedDate
                        }
                    }
                    moc.save(nil)
                }
            }
        }
    }
    
//    class var lists : [List]? {
//        get {
//            if let moc = App.delegate.managedObjectContext {
//                let request = NSFetchRequest(entityName: "WList")
//                if let results = moc.executeFetchRequest(request, error: nil) {
//                    var lists = [List]()
//                    for object in results {
//                        let molist = object as! MOList
//                        lists.append(List(molist: molist))
//                    }
//                    return (lists.count > 0 ? lists : nil)
//                }
//            }
//            return nil
//        }
//        set {
//            if let lists = newValue {
//                if let moc = App.delegate.managedObjectContext {
//                    for list in lists {
//                        var request = NSFetchRequest(entityName: "WList")
//                        request.predicate = NSPredicate(format: "id = %i", list.id)
//                        if let results = moc.executeFetchRequest(request, error: nil){
//                            if(results.isEmpty){
//                                var mo = NSEntityDescription.insertNewObjectForEntityForName("WList", inManagedObjectContext: moc) as! MOList
//                                mo.id = Int32(list.id)
//                                mo.revision = Int32(list.revision)
//                                mo.title = list.title
//                                mo.listType = list.listType.rawValue
//                                mo.lastUsedDate = (list.lastUsedDate != nil ? list.lastUsedDate! : NSDate(timeIntervalSinceReferenceDate: 0))
//                            }
//                        }
//                    }
//                    moc.save(nil)
//                }
//            }
//        }
//    }
//    
//    class func asynchronousFetchLists(completionHandler:(AnyObject?, NSError?) -> Void) {
//        if let moc = App.delegate.managedObjectContext {
//            moc.performBlock({ () -> Void in
//                let request = NSFetchRequest(entityName: "WList")
//                let asyncrequest = NSAsynchronousFetchRequest(fetchRequest: request, completionBlock: { (results) -> Void in
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        completionHandler(results, nil)
//                    })
//                })
//                var error : NSError?
//                let asychresult = moc.executeRequest(asyncrequest, error: &error)
//                if error != nil {
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        completionHandler(nil, error)
//                    })
//                }
//            })
//        }
//    }
//    
//    class func updateList(list:List) {
//        if let moc = App.delegate.managedObjectContext {
//            var request = NSFetchRequest(entityName: "WList")
//            request.predicate = NSPredicate(format: "id = %i", list.id)
//            if let results = moc.executeFetchRequest(request, error: nil){
//                if(results.isEmpty){
//                    var mo = NSEntityDescription.insertNewObjectForEntityForName("WList", inManagedObjectContext: moc) as! MOList
//                    mo.id = Int32(list.id)
//                    mo.revision = Int32(list.revision)
//                    mo.title = list.title
//                    mo.listType = list.listType.rawValue
//                    mo.lastUsedDate = (list.lastUsedDate != nil ? list.lastUsedDate! : NSDate(timeIntervalSinceReferenceDate: 0))
//                } else {
//                    var mo = results.first as! MOList;
//                    mo.id = Int32(list.id)
//                    mo.revision = Int32(list.revision)
//                    mo.title = list.title
//                    mo.listType = list.listType.rawValue
//                    mo.lastUsedDate = (list.lastUsedDate != nil ? list.lastUsedDate! : NSDate(timeIntervalSinceReferenceDate: 0))
//                }
//            }
//            moc.save(nil)
//        }
//    }
    
}
