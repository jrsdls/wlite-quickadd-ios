//
//  WList.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/7/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation

//{
//    "created_at" = "2013-10-05T04:31:17.629Z";
//    id = 86173208;
//    "list_type" = list;
//    "owner_id" = 5980209;
//    "owner_type" = user;
//    public = 0;
//    revision = 16009393;
//    title = "BucketList.Dump";
//    type = list;
//}

class WObject {
    var id = 0
    var revision = 0
    
    init (id:Int, revision:Int){
        self.id = id
        self.revision = revision
    }
}

enum WListListType : String {
    case List = "list"
    case Inbox = "inbox"
}

// Currently unused so commenting out for now
//enum WListType : String {
//    case List = "list"
//}

class WList : WObject{
    // API endpoint properties
    var title = ""
    var listType : WListListType = .List
    
    // local persistent object properties
    var lastUsedDate : NSDate?
    
    // Currently unused so commenting out for now; this are actual Wunderlist List properties
//    var createdAt = ""
//    var ownerId = -1
//    var ispublic = false
//    var type : WListType = .List
    
    convenience init (id:Int, revision:Int, title:String){
        self.init(id: id, revision: revision)
        self.title = title
    }
    
    convenience init (rawList: [String:AnyObject]) {
        let id = rawList["id"] as! Int
        let revision = rawList["revision"] as! Int
        let title = rawList["title"] as! String
        let listType = rawList["list_type"] as! String
        
        self.init(id: id, revision: revision)
        self.title = title
        self.listType = (listType == "inbox" ? .Inbox : .List)
        
        // Currently unused so commenting out for now
//        let createdAt = rawList["created_at"] as! String
//        let ownerId = rawList["owner_id"] as! Int
//        let ownerType = rawList["owner_type"] as! String
//        let ispublic = rawList["public"] as! Int
//        let type = rawList["type"] as! String
//        println("\(createdAt) | \(ownerId) | \(ownerType) | \(ispublic) | \(type)")
        
    }
    
}
