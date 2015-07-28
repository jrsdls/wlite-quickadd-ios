//
//  MOList.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/17/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import CoreData
import Wlite

class MOList: NSManagedObject {
    @NSManaged var id: Int32
    @NSManaged var revision: Int32
    @NSManaged var title: String
    @NSManaged var listType: String
    @NSManaged var lastUsedDate: NSDate
    
    var wlist: List {
        get {
            let wlist = List(title: self.title)
            wlist.id = Int(self.id)
            wlist.revision = Int(self.revision)
            if let listtype = ListType(rawValue: self.listType) {
                wlist.listType = listtype
            }else {
                wlist.listType = .List
            }
            return wlist
        }
    }
    
    var lastUsedDateSortValue : NSTimeInterval {
        get {
            return lastUsedDate.timeIntervalSinceReferenceDate
        }
    }
    
}
