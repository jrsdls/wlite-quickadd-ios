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
