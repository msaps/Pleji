//
//  UIColorUtils.swift
//  HomeSource
//
//  Created by Tengiz Meskhi on 22/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

extension UIColor {
    class func fromHex(hexString: String) -> UIColor {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.startIndex.advancedBy(1)
            let hexColor = hexString.substringFromIndex(start)
            
            if hexColor.characters.count == 8 {
                let scanner = NSScanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexLongLong(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    return UIColor(red: r, green: g, blue: b, alpha: a)
                }
            }
        }
        
        return UIColor.whiteColor()
    }
    
    class func plejiGreen() -> UIColor {
        return UIColor.fromHex("#4CD570FF")
    }
}
