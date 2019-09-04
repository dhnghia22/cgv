//
//  BookingUseCase.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


protocol BookingUseCaseType {
    func getShowTime(sku: String, date: String) -> Observable<[ShowTimeDate]>
}

struct BookingUseCase: BookingUseCaseType {
    let bookingRepository: BookingRepositoryType
    
    func getShowTime(sku: String, date: String) -> Observable<[ShowTimeDate]> {
        return bookingRepository.getShowTime(sku: sku, date: date)
    }
}

