//
//  BookingRequestAPITest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/3/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import XCTest
import Mockingjay
@testable import CGVDemo


class BookingRequestAPITest: XCTestCase {
    
    var bookingRepository: BookingRepository!
    
    override func setUp() {
        super.setUp()
        bookingRepository = BookingRepository()
        
    }
    
    func testGetListCinemaError() {
        let expect = expectation(description: "testGetListCinemaError")
        stub(everything, http(404))
        let loadtrigger = PublishSubject<Void>()
        let testRequest = loadtrigger.flatMap{ _ in
            return self.bookingRepository.getShowTime(sku: "", date: "")
        }
        testRequest.subscribe(onNext: { (cinemas) in
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
    
    func testGetListAPISuccess() {
        let expect = expectation(description: "testGetListAPISuccess")
        
        let json = self.buildResponseWithContentsOfFile("list_show_time")
        let loadtrigger = PublishSubject<Void>()
        stub(everything, jsonData(json))
        
        let testRequest = loadtrigger.flatMap{ _ in
            return self.bookingRepository.getShowTime(sku: "", date: "")
        }
        
        testRequest.subscribe(onNext: { (cinemas) in
            XCTAssertNotNil(cinemas)
            XCTAssertEqual(cinemas[0].locations![0].name, "Hồ Chí Minh")
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
    
    
    
    func testGetListParseError() {
        let expect = expectation(description: "testGetListParseError")
        
        let json = self.buildResponseWithContentsOfFile("error_api")
        let loadtrigger = PublishSubject<Void>()
        stub(everything, jsonData(json))
        
        let testRequest = loadtrigger.flatMap{ _ in
            return self.bookingRepository.getShowTime(sku: "", date: "")
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


