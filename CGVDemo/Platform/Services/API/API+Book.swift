//
//  API+Book.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

extension API {
    func getShowTime(_ input: GetShowTimeInput) -> Observable<[ShowTimeDate]> {
        return requestArray(input)
    }
}

extension API {
    final class GetShowTimeInput: APIInput {
        init(sku: String, date: String) {
            let urlString = String(format: API.Urls.showTime, sku, date)
            super.init(urlString: urlString, parameters: nil, requestType: .get)
        }
    }
}
