//
//  MovieCollectionViewCellTest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo
import XCTest

class MovieCollectionViewCellTest: XCTestCase {
    
    var cell: MovieCollectionViewCell!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        cell = MovieCollectionViewCell.loadFromNib()
    }

    
    func test_ibOulet() {
        XCTAssertNotNil(cell.pagerView)
        XCTAssertNotNil(cell.timeMovieLabel)
        XCTAssertNotNil(cell.bookNowButton)
        XCTAssertNotNil(cell.nameMovieLabel)
        XCTAssertNotNil(cell.ratingImageView)
    }
}
