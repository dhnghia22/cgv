//
//  Dictionary+Ext.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 8/31/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit
extension Dictionary {
    func parseAPIError() throws -> ResponseError? {
        do {
           let data = try JSONSerialization.data(withJSONObject: self,     options: .prettyPrinted)
            return try JSONDecoder().decode(ResponseError.self, from: data)
        } catch let error {
            throw error
        }
    }
    
    func covertToData() throws -> Data {
        do {
            let data = try JSONSerialization.data(withJSONObject: self,     options: .prettyPrinted)
            return data
        } catch let error {
            throw error
        }
    }
}
