//
//  HomeRepository.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

protocol HomeRepositoryType {
    func getListSneakShow(id: Int) -> Observable<[Movie]>
    func getBanner() -> Observable<[Banner]>
    func getCinemas() -> Observable<[CinemaRegion]>
    func getBlog() -> Observable<[Blog]>
}

class HomeRepository: HomeRepositoryType {
    func getListSneakShow(id: Int) -> Observable<[Movie]> {
        let input = API.GetListSnakeShowInput(id: id)
        return API.shared.getSneakShow(input)
    }
    
    func getBanner() -> Observable<[Banner]> {
        return API.shared.getBanner(API.GetBannerInput())
    }
    
    func getCinemas() -> Observable<[CinemaRegion]> {
        return API.shared.getCinemas(API.GetCinemasInput())
    }
    
    func getBlog() -> Observable<[Blog]> {
        return API.shared.getBlog(API.GetBlogInput())
    }
    
}
