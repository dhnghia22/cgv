//
//  MovieViewControllerTest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo
import XCTest

class MovieViewControllerTest: XCTestCase {
    
    var viewController: MovieViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        viewController = MovieViewController.instantiateFromNib()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ibOutlet() {
        viewController.loadView()
        XCTAssertNotNil(viewController.movieTableView)
    }
    
}
