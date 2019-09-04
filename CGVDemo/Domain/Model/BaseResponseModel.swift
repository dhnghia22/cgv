//
//  BaseResponseModel.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation
struct BaseReponseArrayModel<T: Decodable>: Decodable {
    var data: [T]?
}

struct BaseReponseObjectModel<T: Decodable>: Decodable {
    var data: T?
}
