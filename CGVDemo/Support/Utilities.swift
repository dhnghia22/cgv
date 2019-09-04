//
//  Utilities.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


import CoreLocation

func getWindowWidth() -> CGFloat {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    return appDelegate?.window?.frame.width ?? 0
}

func getWindowHeight() -> CGFloat {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    return appDelegate?.window?.frame.height ?? 0
}


func minutesToHoursMinutes (minutes : Int) -> (Int, Int) {
    return (minutes / 60, (minutes % 60))
}

class Utilities {
    class func getNearestCinema(cinemas: [CinemaRegion], from location: CLLocation?) -> Cinema? {
        guard let location = location else { return nil }
        var allCinemas: [Cinema] = []
        for element in cinemas {
            allCinemas.append(contentsOf: element.cinemas ?? [])
        }
        
        let item = allCinemas.min { (lhs, rhs) -> Bool in
            if let lhsLat = lhs.latitude,
                let lhsLong = lhs.longitude,
                let rhsLat = rhs.latitude,
                let rhsLong = rhs.longitude,
                let lhsLatNumber = Double(lhsLat),
                let lhsLongNumber = Double(lhsLong),
                let rhsLatNumber = Double(rhsLat),
                let rhsLongNumber = Double(rhsLong) {
                let lhsCordinate = CLLocation(latitude: lhsLatNumber, longitude: lhsLongNumber)
                let rhsCordinate = CLLocation(latitude: rhsLatNumber, longitude: rhsLongNumber)
                return lhsCordinate.distance(from: location) < rhsCordinate.distance(from: location)
                
            } else {
                return false
            }
        }
        return item
    }
    
    class func getCurentCityCinema(cinemas: [CinemaRegion], from location: CLLocation?) -> CinemaRegion? {
        if let cinema = self.getNearestCinema(cinemas: cinemas, from: location) {
            let filteredCity = cinemas.filter { (item) -> Bool in
                return (item.cinemas ?? []).contains(where: { (subItem) -> Bool in
                    return subItem.id == cinema.id
                })
            }
            return filteredCity.first
        }
        return nil
    }
}

