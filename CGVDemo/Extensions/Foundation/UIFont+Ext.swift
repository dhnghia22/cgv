//
//  UIFont+Ext.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

extension UIFont {
    @nonobjc class func appFont(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        var result: UIFont? = nil
        
        switch weight {
        case .regular:
            result = UIFont(name: "SF-UI-Display-Regular", size: size)
        case .bold:
            result = UIFont(name: "SF-UI-Text-Bold", size: size)
        case .semibold:
            result = UIFont(name: "SF-UI-Display-Semibold", size: size)
        case .medium:
            result = UIFont(name: "SF-UI-Display-Medium", size: size)
            /*
        case .thin:
            result = UIFont(name: "IBMPlexSans-Thin", size: size)
        case .light:
            result = UIFont(name: "IBMPlexSans-Light", size: size)
        case .ultraLight:
            result = UIFont(name: "IBMPlexSans-ExtraLight", size: size)
        case .heavy:
            result = UIFont(name: "IBMPlexSans-Bold", size: size)
        case .black:
            result = UIFont(name: "IBMPlexSans-Bold", size: size)
        default:
            result = UIFont(name: "IBMPlexSans", size: size)
            */
        default:
            result = UIFont(name: "SF-UI-Display-Regular", size: size)
        }
        
        return result ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
}
