//
//  MovieNavigatorMock.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo
import UIKit

final class MovieNavigatorMock: MovieNavigatorType {
    
    var toBookingCalled = false
    func toBooking(movie: Movie) {
        toBookingCalled = true
    }

    var toOfferCalled = false
    func toOfferInfo(blog: Blog) {
        toOfferCalled = true
    }
    
}
