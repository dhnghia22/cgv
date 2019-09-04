//
//  MovieUseCaseMock.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


@testable import CGVDemo

final class MovieUseCaseMock: MovieUseCaseType {
    
    var getMovieCalled = false
    var getMovieReturnValue: Observable<Movie> = Observable.just(Movie.mock())
    func getMovie(id: String) -> Observable<Movie> {
        getMovieCalled = true
        return getMovieReturnValue
    }
    
    
}

