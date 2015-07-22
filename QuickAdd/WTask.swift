//
//  WTask.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/22/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation

class WTask : WObject {
    var title = ""
    var listId = 0
    
    convenience init (title:String, listId:Int){
        self.init(id: 0, revision: 0)
        self.title = title
        self.listId = listId
    }
    
    convenience init (id:Int, revision:Int, title:String, listId:Int){
        self.init(id: id, revision: revision)
        self.title = title
        self.listId = listId
    }
    
}