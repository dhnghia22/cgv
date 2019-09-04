//
//  HomeRequestAPITest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/3/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


import XCTest
import Mockingjay
@testable import CGVDemo


extension XCTest {
    func buildResponseWithContentsOfFile(_ fileName: String?) -> Data {
        let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json")!
        return (NSData(contentsOfFile: path)! as! Data)
    }
}


class HomeRequestAPITest: XCTestCase {
    
    var homeRepository: HomeRepository!
    
    override func setUp() {
        super.setUp()
        homeRepository = HomeRepository()
        
    }
    
    
    //MARK: GET LIST CINEMA
    
    func testGetListCinemaError() {
        //arrange
        let expect = expectation(description: "testGetListCinemaError")
        stub(everything, http(401))
        let loadtrigger = PublishSubject<Void>()
        let testRequest = loadtrigger.flatMap{ _ in
            return self.homeRepository.getCinemas()
        }
        
        //test
        testRequest.subscribe(onNext: { (cinemas) in
            XCTFail()
            expect.fulfill()
        }, onError: { (error) in
            if let err = error as? API.APIError {
                print(err.description)
            }
            XCTAssertNotNil(error)
            expect.fulfill()
        }).disposed(by: rx.disposeBag)
        
        //trigger event
        loadtrigger.onNext(())
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testGetListCinemaAPISuccess() {
        // arrange
        let expect = expectation(description: "testGetListCinemaAPISuccess")
        let json = self.buildResponseWithContentsOfFile("list_cinema")
        
        let loadtrigger = PublishSubject<Void>()
        stub(everything, jsonData(json))
//        stub(everything, http(401))
        
        let testRequest = loadtrigger.flatMap{ _ in
            return self.homeRepository.getCinemas()
        }
        
        testRequest.subscribe(onNext: { (cinemas) in
            XCTAssertNotNil(cinemas)
            XCTAssertEqual(cinemas.count, 27)
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
    
    
     //MARK: GET LIST BANNER
    func testGetListBannerAPISuccess() {
        // arrange
        let expect = expectation(description: "testGetListBannerAPISuccess")
        let json = self.buildResponseWithContentsOfFile("list_banner")
        
        let loadtrigger = PublishSubject<Void>()
        stub(everything, jsonData(json))
        //        stub(everything, http(401))
        
        let testRequest = loadtrigger.flatMap{ _ in
            return self.homeRepository.getBanner()
        }
        
        testRequest.subscribe(onNext: { (banners) in
            XCTAssertNotNil(banners)
            XCTAssertEqual(banners.count, 6)
            XCTAssertEqual(banners[0].id, "2022")
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
    
    
    func testGetListBannerCinemaError() {
        //arrange
        let expect = expectation(description: "testGetListBannerCinemaError")
        stub(everything, http(401))
        let json = self.buildResponseWithContentsOfFile("error_api")
        stub(everything, jsonData(json))
        let loadtrigger = PublishSubject<Void>()
        let testRequest = loadtrigger.flatMap{ _ in
            return self.homeRepository.getBanner()
        }
        
        //test
        testRequest.subscribe(onNext: { (banners) in
            XCTFail()
            expect.fulfill()
        }, onError: { (error) in
            if let err = error as? API.APIError {
                print(err.description)
            }
            XCTAssertNotNil(error)
            expect.fulfill()
        }).disposed(by: rx.disposeBag)
        
        //trigger event
        loadtrigger.onNext(())
        
        wait(for: [expect], timeout: 0.1)
    }
    
    //MARK: GET LIST MOVIE
    
    func testGetListMovieAPISuccess() {
        // arrange
        let expect = expectation(description: "testGetListMovieAPISuccess")
        let json = self.buildResponseWithContentsOfFile("list_movie")
        
        let loadtrigger = PublishSubject<Void>()
        stub(everything, jsonData(json))
        //        stub(everything, http(401))
        
        let testRequest = loadtrigger.flatMap{ _ in
            return self.homeRepository.getListSneakShow(id: 2)
        }
        
        testRequest.subscribe(onNext: { (movie) in
            XCTAssertNotNil(movie)
            XCTAssertTrue(movie.count > 0)
            XCTAssertEqual(movie[0].name, "ANH THẦY NGÔI SAO")
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
    
    
    func testGetListMovieError() {
        //arrange
        let expect = expectation(description: "testGetListMovieError")
        stub(everything, http(404))
        let json = self.buildResponseWithContentsOfFile("error_api")
//        stub(everything, jsonData(json))
        let loadtrigger = PublishSubject<Void>()
        let testRequest = loadtrigger.flatMap{ _ in
            return self.homeRepository.getListSneakShow(id: 2)
        }
        
        //test
        testRequest.subscribe(onNext: { (banners) in
            XCTFail()
            expect.fulfill()
        }, onError: { (error) in
            if let err = error as? API.APIError {
                print(err.description)
            }
            XCTAssertNotNil(error)
            expect.fulfill()
        }).disposed(by: rx.disposeBag)
        
        //trigger event
        loadtrigger.onNext(())
        
        wait(for: [expect], timeout: 0.1)
    }
    
    //MARK: GET LIST BLOG (OFFER AND ADS)
    
    func testGetListBlogAPISuccess() {
        // arrange
        let expect = expectation(description: "testGetListBlogAPISuccess")
        let json = self.buildResponseWithContentsOfFile("list_blog")
        
        let loadtrigger = PublishSubject<Void>()
        stub(everything, jsonData(json))
        //        stub(everything, http(401))
        
        let testRequest = loadtrigger.flatMap{ _ in
            return self.homeRepository.getBlog()
        }
        
        testRequest.subscribe(onNext: { (blog) in
            XCTAssertNotNil(blog)
            XCTAssertTrue(blog.count > 0)
            XCTAssertEqual(blog[0].title, "EXIT - LỐI THOÁT TRÊN KHÔNG - 49K")
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
    
    
    func testGetListBannerError() {
        //arrange
        let expect = expectation(description: "testGetListBannerError")
//        stub(everything, http(404))
        let json = self.buildResponseWithContentsOfFile("error_api")
        stub(everything, jsonData(json))
        let loadtrigger = PublishSubject<Void>()
        let testRequest = loadtrigger.flatMap{ _ in
            return self.homeRepository.getBlog()
        }
        
        //test
        testRequest.subscribe(onNext: { (blog) in
            XCTFail()
            expect.fulfill()
        }, onError: { (error) in
            if let err = error as? API.APIError {
                print(err.description)
            }
            XCTAssertNotNil(error)
            expect.fulfill()
        }).disposed(by: rx.disposeBag)
        
        //trigger event
        loadtrigger.onNext(())
        
        wait(for: [expect], timeout: 0.1)
    }

}

