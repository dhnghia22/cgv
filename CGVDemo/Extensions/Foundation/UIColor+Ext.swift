//
//  UIColor+Ext.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255
        let g = CGFloat((hex & 0x00ff00) >> 8) / 255
        let b = CGFloat((hex & 0x0000ff)) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat(red) / 255
        let g = CGFloat(green) / 255
        let b = CGFloat(blue) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(white: Int, alpha: CGFloat = 1.0) {
        self.init(white: CGFloat(white) / 255.0, alpha: alpha)
    }
}


extension UIColor {
    
    @nonobjc class var mainTextColor: UIColor {
        return UIColor(hex: 0x493C30)
    }
    
    @nonobjc class var mainRedColor: UIColor {
        return UIColor(hex: 0xAE2C32)
    }
    
    @nonobjc class var athensGray: UIColor {
        return UIColor(red: 244, green: 245, blue: 247)
    }
    
    @nonobjc class var mischka: UIColor {
        return UIColor(red: 217, green: 220, blue: 226, alpha: 1.0)
    }
    
    @nonobjc class var razzmatazz: UIColor {
        return UIColor(red: 217, green: 14, blue: 93, alpha: 1.0)
    }
    
    @nonobjc class var gallery: UIColor {
        return UIColor(red: 238, green: 238, blue: 238, alpha: 1.0)
    }
    
    @nonobjc class var downriver: UIColor {
        return UIColor(red: 9, green: 30, blue: 66, alpha: 1.0)
    }
    
    @nonobjc class var sunsetOrange: UIColor {
        return UIColor(red: 255, green: 78, blue: 78, alpha: 1.0)
    }
    
    @nonobjc class var fiord: UIColor {
        return UIColor(red: 66, green: 82, blue: 110, alpha: 1.0)
    }
    
    @nonobjc class var barTint: UIColor {
        return UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
    }
    
    @nonobjc class var statusBackground: UIColor {
        return UIColor(red: 245, green: 245, blue: 245, alpha: 1.0)
    }
    
    @nonobjc class var redErrorBackground: UIColor {
        return UIColor(red: 255, green: 238, blue: 244, alpha: 0.4)
    }
    
    @nonobjc class var downRiver: UIColor {
        return UIColor(red: 9, green: 30, blue: 66, alpha: 1.0)
    }
    
    @nonobjc class var slateGray: UIColor {
        return UIColor(red: 122, green: 134, blue: 154, alpha: 1.0)
    }
    
    @nonobjc class var chambray: UIColor {
        return UIColor(red: 64, green: 89, blue: 147, alpha: 1.0)
    }
    
    @nonobjc class var lightGrey: UIColor {
        return UIColor(red: 48, green: 53, blue: 6, alpha: 1.0)
    }
    
    @nonobjc class var porcelain: UIColor {
        return UIColor(red: 243, green: 244, blue: 245, alpha: 1.0)
    }
    
    @nonobjc class var cadetBlue: UIColor {
        return UIColor(red: 179, green: 186, blue: 197, alpha: 1.0)
    }
    
    @nonobjc class var mineShaft: UIColor {
        return UIColor(red: 40, green: 40, blue: 40, alpha: 1.0)
    }
    
    @nonobjc class var doveGray: UIColor {
        return UIColor(red: 99, green: 99, blue: 99, alpha: 1.0)
    }
    
    @nonobjc class var cardinal: UIColor {
        return UIColor(red: 187, green: 34, blue: 67, alpha: 1.0)
    }
    
    @nonobjc class var rose: UIColor {
        return UIColor(red: 255, green: 0, blue: 94, alpha: 1.0)
    }
    
    @nonobjc class var whiteLilac: UIColor {
        return UIColor(red: 248, green: 249, blue: 253, alpha: 0.9)
    }
    
    @nonobjc class var blackPearl: UIColor {
        return UIColor(red: 5, green: 10, blue: 36, alpha: 1.0)
    }
    
    @nonobjc class var backButtonHighLight: UIColor {
        return UIColor(red: 177, green: 186, blue: 201, alpha: 1.0)
    }
    
    @nonobjc class var codGray: UIColor {
        return UIColor(red: 20, green: 20, blue: 20, alpha: 1.0)
    }
    
    @nonobjc class var alto: UIColor {
        return UIColor(red: 217, green: 217, blue: 217, alpha: 1.0)
    }
}


