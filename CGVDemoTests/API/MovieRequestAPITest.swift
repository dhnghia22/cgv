//
//  MovieRequestAPITest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import XCTest
import Mockingjay
@testable import CGVDemo


class MovieRequestAPITest: XCTestCase {
    
    var movieRepository: MovieRepository!
    
    override func setUp() {
        super.setUp()
        movieRepository = MovieRepository()
        
    }
    
    
    func testGetListAPISuccess() {
        let expect = expectation(description: "testGetListAPISuccess")
        
        let json = self.buildResponseWithContentsOfFile("movie_detail")
        let loadtrigger = PublishSubject<Void>()
        stub(everything, jsonData(json))
        
        let testRequest = loadtrigger.flatMap{ _ in
            return self.movieRepository.getMovie(id: "000")
        }
        
        testRequest.subscribe(onNext: { (movie) in
            XCTAssertNotNil(movie)
            XCTAssertEqual(movie.sku, "19013600")
            expect.fulfill()
        }, onError: { (error) in
            if let err = error as? API.APIError {
                print(err.description)
            }
            XCTAssertNotNil(error)
            XCTFail()
        }).disposed(by: rx.disposeBag)
        
        loadtrigger.onNext(())
        wait(for: [expect], timeout: 0.1)
    }
    
    
    
    func testMovieCinemaError() {
        let expect = expectation(description: "testMovieCinemaError")
        stub(everything, http(404))
        let loadtrigger = PublishSubject<Void>()
        let testRequest = loadtrigger.flatMap{ _ in
            return self.movieRepository.getMovie(id: "000")
        }
        testRequest.subscribe(onNext: { (movie) in
            XCTFail()
            expect.fulfill()
        }, onError: { (error) in
            if let err = error as? API.APIError {
                print(err.description)
                XCTAssertEqual(err.description, "Unknow error 404")
            }
            XCTAssertNotNil(error)
            expect.fulfill()
        }).disposed(by: rx.disposeBag)
        loadtrigger.onNext(())
        
        wait(for: [expect], timeout: 0.1)
    }
    
    func testGetListParseError() {
        let expect = expectation(description: "testGetListParseError")
        
        let json = self.buildResponseWithContentsOfFile("error_api")
        let loadtrigger = PublishSubject<Void>()
        stub(everything, jsonData(json))
        
        let testRequest = loadtrigger.flatMap{ _ in
            return self.movieRepository.getMovie(id: "000")
        }
        
        testRequest.subscribe(onNext: { (cinemas) in
            XCTFail()
            expect.fulfill()
        }, onError: { (error) in
            if let err = error as? API.APIError {
                print(err.description)
                XCTAssertEqual(err.description, "Please check your local time.")
            }
            XCTAssertNotNil(error)
            expect.fulfill()
        }).disposed(by: rx.disposeBag)
        
        loadtrigger.onNext(())
        wait(for: [expect], timeout: 0.1)
    }
}
