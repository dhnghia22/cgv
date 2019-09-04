//
//  HomeUseCase.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation


protocol HomeUseCaseType {
    func getSneakShow(id: Int) -> Observable<[Movie]>
    func getBanner() -> Observable<[Banner]>
    func getCinemas() -> Observable<[CinemaRegion]>
    func getBLog() -> Observable<[Blog]>
}

struct HomeUseCase: HomeUseCaseType {
    let homeRepository: HomeRepositoryType
    
    func getSneakShow(id: Int) -> Observable<[Movie]> {
        return homeRepository.getListSneakShow(id: id)
    }
    
    func getBanner() -> Observable<[Banner]> {
        return homeRepository.getBanner()
    }
    
    func getCinemas() -> Observable<[CinemaRegion]> {
        return homeRepository.getCinemas()
    }
    
    func getBLog() -> Observable<[Blog]> {
        return homeRepository.getBlog()
    }
    
}
