//
//  Cinema.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation
import CoreLocation

struct CinemaRegion: Codable {
    let name: String?
    let cinemas: [Cinema]?
    
    enum CodingKeys: String, CodingKey {
        case name, cinemas
    }
}

struct Cinema: Codable {
    let id, code, name: String?
    let thumbnail: String?
    let latitude, longitude, address: String?
    let isGerp: Bool?
    let images: [String]?
    let specials: [Special]?
    
    enum CodingKeys: String, CodingKey {
        case id, code, name, thumbnail, latitude, longitude, address
        case isGerp = "is_gerp"
        case images, specials
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


struct Special: Codable {
    let title: String?
    let id: Int?
    let code: String?
    let smallImage, mainImage: String?
    
    enum CodingKeys: String, CodingKey {
        case title, id, code
        case smallImage = "small_image"
        case mainImage = "main_image"
    }
}

extension Sequence where Iterator.Element == CinemaRegion {
}
