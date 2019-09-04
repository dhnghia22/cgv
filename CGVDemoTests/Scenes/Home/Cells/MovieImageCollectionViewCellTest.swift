//
//  MovieImageCollectionViewCellTest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import XCTest
@testable import CGVDemo

class MovieImageCollectionViewCellTest: XCTestCase {

    var cell: MovieImageCollectionViewCell!
    
    override func setUp() {
        super.setUp()
        cell = MovieImageCollectionViewCell.loadFromNib()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func test_ibOulet() {
        XCTAssertNotNil(cell.movieImageView)
        XCTAssertNotNil(cell.indexLabel)
    }

}
