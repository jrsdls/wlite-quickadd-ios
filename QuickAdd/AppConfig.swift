//
//  AppConfig.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/7/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation

struct App {
    static var clientID : String {
        return "f3ea79fd629ba3d2e252"
    }
    static var clientSecret : String {
        return "014a02f469a452a8ba3f2d8f0246499a0ac8babe1eb180abfb03516f6512"
    }
    static var accessToken : String? {
        get {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            return userDefaults.stringForKey("com.wlite.oauth.accessToken")
        }
        set {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(newValue, forKey: "com.wlite.oauth.accessToken")
        }
    }
}
