//
//  HomeUseCaseMock.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


@testable import CGVDemo

final class HomeUseCaseMock: HomeUseCaseType {
    
    var getSneakShowCalled = false
    var getSneakShowReturnValue: Observable<[Movie]> = Observable.just([CGVDemo.Movie.mock()])
    func getSneakShow(id: Int) -> Observable<[Movie]> {
        getSneakShowCalled = true
        return getSneakShowReturnValue
    }
    
    
    var getBannersCalled = false
    var getBannersReturnValue: Observable<[Banner]> = Observable.just([CGVDemo.Banner.mock()])
    func getBanner() -> Observable<[Banner]> {
        getBannersCalled = true
        return getBannersReturnValue
    }
    
    var getCinemasCalled = false
    var getCinemasReturnValue: Observable<[CinemaRegion]> = Observable.just([CGVDemo.CinemaRegion.mock()])
    func getCinemas() -> Observable<[CinemaRegion]> {
        getCinemasCalled = true
        return getCinemasReturnValue
    }
    
    var getBlogCalled = false
    var getBlogReturnValue: Observable<[Blog]> = Observable.just([CGVDemo.Blog.mock()])
    func getBLog() -> Observable<[Blog]> {
        getBlogCalled = true
        return getBlogReturnValue
    }
    
    
}
