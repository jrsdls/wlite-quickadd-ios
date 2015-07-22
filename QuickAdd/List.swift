//
//  List.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/22/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation

class List : WList {
    // local persistent object properties
    var lastUsedDate : NSDate?
    
    var lastUsedDateSortValue : NSTimeInterval {
        var val = 0.0
        if let date = lastUsedDate {
            val = date.timeIntervalSinceReferenceDate
        }
        return val
    }
    
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

func listsFromRawLists(rawlists:[[String:AnyObject]]) -> [List]{
    var lists = [List]()
    for rawList in rawlists {
        lists.append(List(rawList: rawList))
    }
    return lists
}

func listsFromMOLists(molists:[MOList]) -> [List]{
    var lists = [List]()
    for molist in molists {
        lists.append(List(molist: molist))
    }
    return lists
}