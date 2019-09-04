//
//  Date+Ext.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

extension Date {
    func convertToString(format: String) -> String? {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: self)
    }
}
