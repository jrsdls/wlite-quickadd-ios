//
//  LocalStore.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/22/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation
import CoreData
import Wlite



class LocalStore {
    
    var context:NSManagedObjectContext
    
    init(context:NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchAllLists() -> [MOList] {
        var lists = [MOList]()
        let request = NSFetchRequest(entityName: "List")
        if let results = context.executeFetchRequest(request, error: nil) {
            for object in results {
                let molist = object as! MOList
                lists.append(molist)
            }
        }
        return lists
    }
    
    func fetchList(listid:Int32) -> MOList?{
        var mo:MOList? = nil
        var request = NSFetchRequest(entityName: "List")
        request.predicate = NSPredicate(format: "id = %i", listid)
        if let results = context.executeFetchRequest(request, error: nil) {
            if(!results.isEmpty){
                mo = results.first as? MOList
            }
        }
        return mo
    }
    
    func fetchList(listid:Int) -> MOList? {
        return fetchList(Int32(listid))
    }
    
    func updateList(list:MOList){
        if let fetchedList = fetchList(list.id) {
            fetchedList.revision = list.revision
            fetchedList.title = list.title
            fetchedList.listType = list.listType
            fetchedList.lastUsedDate = list.lastUsedDate
        }
    }
    
    func createOrUpdateList(wlist:List) -> MOList{
        var mo:MOList! = nil
        if let fetchedList = fetchList(Int32(wlist.id)) {
            mo = fetchedList
        }else {
            mo = NSEntityDescription.insertNewObjectForEntityForName("List", inManagedObjectContext: context) as! MOList
        }
        mo.id = Int32(wlist.id)
        mo.revision = Int32(wlist.revision)
        mo.title = wlist.title
        mo.listType = wlist.listType.rawValue
        return mo
    }
    
    func save() {
        context.save(nil)
    }
    
}
