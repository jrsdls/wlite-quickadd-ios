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

enum WListType : String {
    case List = "list"
    case Inbox = "inbox"
}

class WList : WObject{
    var title = ""
    var listType : WListType = .List
    
    convenience init (id:Int, revision:Int, title:String){
        self.init(id: id, revision: revision)
        self.title = title
    }
    
    convenience init (rawList: [String:AnyObject]) {
        let id = rawList["id"] as! Int
        let revision = rawList["revision"] as! Int
        let title = rawList["title"] as! String
//        let createdAt = rawList["created_at"]
        let listType = rawList["list_type"] as! String
//        let ownerId = rawList["owner_id"]
//        let ownerType = rawList["owner_type"]
//        let ispublic = rawList["public"]
//        let type = rawList["type"]

        self.init(id: id, revision: revision)
        self.title = title
        self.listType = (listType == "inbox" ? .Inbox : .List)
        
    }
    
}