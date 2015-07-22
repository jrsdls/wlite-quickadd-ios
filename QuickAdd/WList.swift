//
//  WList.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/7/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation

enum WListListType : String {
    case List = "list"
    case Inbox = "inbox"
}

class WList : WObject{
    var title = ""
    var listType : WListListType = .List
    
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
    }
    
}
