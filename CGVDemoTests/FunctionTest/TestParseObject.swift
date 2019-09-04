//
//  TestParseObject.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import XCTest
@testable import CGVDemo

class TestParseObject: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_parse_showTime() {
        do {
            let json = self.buildResponseWithContentsOfFile("list_show_time")
            let data = try JSONDecoder().decode(BaseReponseArrayModel<ShowTimeDate>.self, from: json)
            XCTAssertNotNil(data.data)
            XCTAssertTrue(data.data!.count > 0)
            XCTAssertEqual(data.data![0].date, "2019-09-02")
            XCTAssertEqual(data.data![0].locations![0].name, "Hồ Chí Minh")
        } catch let err {
            print(err.localizedDescription)
            XCTFail()
        }
    }
}
