//
//  WObject.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/22/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation

class WObject {
    var id = 0
    var revision = 0
    
    init (id:Int, revision:Int){
        self.id = id
        self.revision = revision
    }
}