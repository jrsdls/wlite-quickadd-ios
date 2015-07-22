//
//  CloudStore.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/22/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation
import Alamofire
import Common

class CloudStore {
    
    class func fetchLists(completionHandler:(NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
        Alamofire
            .request(CListRouter.ReadLists())
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    class func createTask(task:WTask, completionHandler:(NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
        let parameters : [ String : AnyObject] = [
            "title": task.title,
            "list_id": task.listId
        ]
        Alamofire
            .request(CTaskRouter.CreateTask(parameters))
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
}
