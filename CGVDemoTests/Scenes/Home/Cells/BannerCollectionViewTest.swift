//
//  BannerCollectionViewTest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo
import XCTest

class BannerCollectionViewTest: XCTestCase {

    var cell: BannerCollectionViewCell!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        cell = BannerCollectionViewCell.loadFromNib()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_ibOutlet() {
        XCTAssertNotNil(cell.collectionView)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
