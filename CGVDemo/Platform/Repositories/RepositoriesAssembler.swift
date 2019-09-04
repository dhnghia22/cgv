//
//  RepositoriesAssembler.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

protocol RepositoriesAssembler {
    func resolve() -> HomeRepositoryType
    func resolve() -> MovieRepositoryType
    func resolve() -> BookingRepositoryType
    func resolve() -> BlogRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler  {
    func resolve() -> HomeRepositoryType {
        return HomeRepository()
    }
    
    func resolve() -> MovieRepositoryType {
        return MovieRepository()
    }
    
    func resolve() -> BookingRepositoryType {
        return BookingRepository()
    }
    
    func resolve() -> BlogRepositoryType {
        return BlogRepository()
    }
}
