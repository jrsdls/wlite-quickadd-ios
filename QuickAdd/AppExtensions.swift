//
//  AppExtensions.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/7/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    // http://www.google.com/design/spec/style/color.html#color-color-palette
    
    class func appMainColor() -> UIColor {
        return UIColor(hex: 0x2A87D5) // http://colllor.com/2A87D5
    }
    
    class func appDarkMainColor() -> UIColor {
        return UIColor(hex: 0x1E6299)
    }
    
    class func appGreyColor() -> UIColor{
        return UIColor(hex: 0x071622)
    }
    
}