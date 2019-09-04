//
//  APIOutput.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 8/31/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

class APIOutputBase: Decodable {
    
}

struct APIResponseModel<T: Decodable>: Decodable {
    var data: T?
}
struct APIResponseArrayModel<T: Decodable>: Decodable {
    var data: [T]?
}


