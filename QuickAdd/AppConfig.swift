//
//  AppConfig.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/7/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import CoreData
import Wlite

class App {
    
    // Wlite
    static var wlite: Wlite!
    
    // AppDelegate
    static var delegate : AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }
    
}

