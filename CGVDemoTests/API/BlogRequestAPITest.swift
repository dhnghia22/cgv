//
//  BlogRequestAPITest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import XCTest
import Mockingjay
@testable import CGVDemo


class BlogRequestAPITest: XCTestCase {
    
    var blogRepository: BlogRepository!
    
    override func setUp() {
        super.setUp()
        blogRepository = BlogRepository()
        
    }
    
    
    func testGetBlogDetailAPISuccess() {
        let expect = expectation(description: "testGetBlogDetailAPISuccess")
        
        let json = self.buildResponseWithContentsOfFile("blog_detail")
        let loadtrigger = PublishSubject<Void>()
        stub(everything, jsonData(json))
        
        let testRequest = loadtrigger.flatMap{ _ in
            return self.blogRepository.getBlogDetail(blogId: "000")
        }
        
        testRequest.subscribe(onNext: { (blog) in
            XCTAssertNotNil(blog)
            XCTAssertEqual(blog.title, "EXIT - LỐI THOÁT TRÊN KHÔNG - 49K")
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
    
    
    
    func testMovieDetailError() {
        let expect = expectation(description: "testMovieDetailError")
        stub(everything, http(404))
        let loadtrigger = PublishSubject<Void>()
        let testRequest = loadtrigger.flatMap{ _ in
            return self.blogRepository.getBlogDetail(blogId: "000")
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
    
    func testGetMovieDetailParseError() {
        let expect = expectation(description: "testGetMovieDetailParseError")
        
        let json = self.buildResponseWithContentsOfFile("error_api")
        let loadtrigger = PublishSubject<Void>()
        stub(everything, jsonData(json))
        
        let testRequest = loadtrigger.flatMap{ _ in
            return self.blogRepository.getBlogDetail(blogId: "000")
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

