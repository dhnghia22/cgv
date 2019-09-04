//
//  ShowTime.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation
import CoreLocation

struct ShowTimeDate: Decodable {
    let date: String?
    let locations: [ShowTimeLocation]?
}


struct ShowTimeLocation: Decodable {
    let name: String?
    let cinemas: [ShowTimeCinema]?
}

struct ShowTimeCinema: Decodable {
    
    let id, name, latitude, longitude: String?
    let languages: [Language]?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case latitude
        case longitude
        case languages
    }
    
    func getDistance(from location: CLLocation?) -> Double? {
        if let location = location,
            let lat = self.latitude,
            let long = self.longitude,
            let latNumber = Double(lat),
            let longNumber = Double(long) {
            let cordinate = CLLocation(latitude: latNumber, longitude: longNumber)
            return cordinate.distance(from: location)
        }
        return nil
    }
}



struct Language: Codable {
    let name, nameColor, code: String?
    let sessions : [Session]?
    enum CodingKeys: String, CodingKey {
        case name
        case nameColor = "name_color"
        case code
        case sessions
    }
}

struct Session: Codable {
    let id: Int?
    let cinemaID, time, room, theater: String?
    let isBooking: Bool?
    let code: String?
    let remainingSeats: Int?
    let subType, showingDateTime, showingType: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cinemaID = "cinema_id"
        case time, room, theater
        case isBooking = "is_booking"
        case code
        case remainingSeats = "remaining_seats"
        case subType = "sub_type"
        case showingDateTime = "showing_date_time"
        case showingType = "showing_type"
    }
}
