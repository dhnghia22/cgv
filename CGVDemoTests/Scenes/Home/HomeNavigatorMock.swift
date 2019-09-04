//
//  HomeNavigatorMock.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo
import UIKit

final class HomeNavigatorMock: HomeNavigatorType {
    
    var toMovieCalled = false
    func toMovie(sneakShow: Movie, blogs: [Blog]) {
        toMovieCalled = true
    }
    
    var toOfferCalled = false
    func toOfferInfo(blogId: String)  {
        toOfferCalled = true
    }
    
    var toBannerCalled = false
    func toBanner(banner: Banner, blogs: [Blog]) {
        toBannerCalled = true
    }
    
    var toBookCalled = false
    func toBook(movie: Movie) {
        toBookCalled = true
    }
    
    
}
