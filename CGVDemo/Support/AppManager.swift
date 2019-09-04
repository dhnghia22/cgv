//
//  AppManager.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/3/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

class AppManager {
    static let shared = AppManager()
    private var city: CinemaRegion?
    
    func set(city: CinemaRegion?) {
        self.city = city
    }
    
    func getCity() -> CinemaRegion? {
        return city
    }
}
