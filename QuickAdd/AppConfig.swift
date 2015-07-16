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
    static var defaultList : WList? {
        get {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if (userDefaults.objectForKey("com.wlite.oauth.defaultList.title") != nil) {
                let id = userDefaults.integerForKey("com.wlite.oauth.defaultList.id")
                let revision = userDefaults.integerForKey("com.wlite.oauth.defaultList.revision")
                let title = userDefaults.stringForKey("com.wlite.oauth.defaultList.title")
                return WList(id: id, revision: revision, title: title!)
            }
            else {
                return nil
            }
        }
        set {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setInteger(newValue!.id, forKey: "com.wlite.oauth.defaultList.id")
            userDefaults.setInteger(newValue!.revision, forKey: "com.wlite.oauth.defaultList.revision")
            userDefaults.setObject(newValue!.title, forKey: "com.wlite.oauth.defaultList.title")
        }
    }
}
