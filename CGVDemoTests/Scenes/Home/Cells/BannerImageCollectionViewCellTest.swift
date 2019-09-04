//
//  BannerImageCollectionViewCellTest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo
import XCTest

class BannerImageCollectionViewCellTest: XCTestCase {
    
    var cell: BannerImageCollectionViewCell!

    override func setUp() {
        super.setUp()
        cell = BannerImageCollectionViewCell.loadFromNib()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_ibOulet() {
        XCTAssertNotNil(cell.bannerImageView)
    }

}
