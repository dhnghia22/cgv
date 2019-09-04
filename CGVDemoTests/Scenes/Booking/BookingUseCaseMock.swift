//
//  BookingUseCaseMock.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo

final class BookingUseCaseMock: BookingUseCaseType {
    var getShowTimeCalled = false
    var getShowTimeReturnValue: Observable<[ShowTimeDate]> = Observable.just([ShowTimeDate.mock()])
    func getShowTime(sku: String, date: String) -> Observable<[ShowTimeDate]> {
        getShowTimeCalled = true
        return getShowTimeReturnValue
    }
}



