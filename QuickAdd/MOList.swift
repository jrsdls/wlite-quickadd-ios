//
//  MOList.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/17/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import CoreData

class MOList: NSManagedObject {
    @NSManaged var id: Int32
    @NSManaged var revision: Int32
    @NSManaged var title: String
    @NSManaged var listType: String
    @NSManaged var lastUsedDate: NSDate
}

extension WList {
    convenience init(molist: MOList) {
        let id = Int(molist.id)
        let revision = Int(molist.revision)
        let title = molist.title
        let listType = molist.listType
        let lastUsedDate = molist.lastUsedDate
        
        self.init(id: id, revision: revision)
        self.title = title
        self.listType = (listType == "inbox" ? .Inbox : .List)
        self.lastUsedDate = (lastUsedDate.timeIntervalSinceReferenceDate > 0 ? lastUsedDate : nil)
        
    }
}
