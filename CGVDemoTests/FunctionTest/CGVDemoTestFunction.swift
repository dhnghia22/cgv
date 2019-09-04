//
//  CGVDemoTestFunction.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 8/31/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import XCTest
import CoreLocation
@testable import CGVDemo


class CGVDemoTestFunction: XCTestCase {
    
    func testParseError() {
        let errString = """
        {
            "errors": [
                {
                    "detail": "Please check your local time."
                }
            ]
        }
        """
        if let data = errString.data(using: .utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let errorResponse =
                        try json.parseAPIError()
                    XCTAssertNotNil(errorResponse)
                } else {
                    XCTFail()
                }
            } catch let err {
                print(err.localizedDescription)
                XCTFail()
            }
        } else {
            XCTFail()
        }
    }
    
    func testGetNearestCinema() {
        do {
            let fileName = "list_cinema"
            let file = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json")
            let json = try Data(contentsOf: URL(fileURLWithPath: file!))
            let data = try JSONDecoder().decode(BaseReponseArrayModel<CinemaRegion>.self, from: json)
            //        10.783236, 106.658621
            let currentLocation = CLLocation(latitude: 10.783236, longitude: 106.658621)
            let ciname = Utilities.getNearestCinema(cinemas: data.data ?? [], from: currentLocation)
            XCTAssertNotNil(ciname)
            XCTAssertEqual(ciname!.id, "033")
        } catch let err {
            print(err.localizedDescription)
            XCTFail()
        }
    }
    
    func testParseDateTimeString() {
        let time = "2019-08-30 00:00:00"
        let date = time.convertToDate(format: "yyyy-MM-dd hh:mm:ss")
        XCTAssertNotNil(date)
        let string = date!.convertToString(format: "d MMM, yyyy")
        XCTAssertNotNil(string)
        XCTAssertEqual(string!, "30 Aug, 2019")
    }
    
    func testGetCurrentCity() {
        do {
            let fileName = "list_cinema"
            let file = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json")
            let json = try Data(contentsOf: URL(fileURLWithPath: file!))
            let data = try JSONDecoder().decode(BaseReponseArrayModel<CinemaRegion>.self, from: json)
            //        10.783236, 106.658621
            let currentLocation = CLLocation(latitude: 10.783236, longitude: 106.658621)
            if let cinema = Utilities.getCurentCityCinema(cinemas: (data.data ?? []), from: currentLocation) {
                XCTAssertEqual(cinema.name, "Hồ Chí Minh")
            } else {
                XCTFail()
            }

        } catch let err {
            print(err.localizedDescription)
            XCTFail()
        }
    }
}
