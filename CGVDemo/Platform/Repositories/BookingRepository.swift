//
//  BookingRepository.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

protocol BookingRepositoryType {
    func getShowTime(sku: String, date: String) -> Observable<[ShowTimeDate]>
}

class BookingRepository: BookingRepositoryType {
    func getShowTime(sku: String, date: String) -> Observable<[ShowTimeDate]> {
        return API.shared.getShowTime(API.GetShowTimeInput(sku: sku, date: date))
    }
}
