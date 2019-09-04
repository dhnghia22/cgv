//
//  LocationManager.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation
import CoreLocation
import RxCoreLocation

class LocationManager {
    static let shared = LocationManager()
    let manager: CLLocationManager = CLLocationManager()
    let bag = DisposeBag()
    var location: CLLocation?
    
    func request() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        manager.rx.didUpdateLocations.subscribe(onNext: { (agr) in
            self.location = agr.locations.last
            agr.manager.stopUpdatingLocation()
        }).disposed(by: bag)
        
        manager.rx.didError.subscribe(onNext: { (agr) in
            agr.manager.requestLocation()
        }).disposed(by: bag)
    }
}
