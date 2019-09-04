//
//  API+Home.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import RxSwift

extension API {
    func getSneakShow(_ input: GetListSnakeShowInput) -> Observable<[Movie]> {
        return requestArray(input)
    }
    func getBanner(_ input: GetBannerInput) -> Observable<[Banner]> {
        return requestArray(input)
    }
    
    func getCinemas(_ input: GetCinemasInput) -> Observable<[CinemaRegion]> {
        return requestArray(input)
    }
    
    func getBlog(_ input: GetBlogInput) -> Observable<[Blog]> {
        return requestArray(input)
    }
}

extension API {
    final class GetListSnakeShowInput: APIInput {
        init(id: Int) {
            let params: [String: Any] = [
                "cat": id
            ]
            let urlString = API.Urls.listSneakShow
            super.init(urlString: urlString,
                       parameters: params,
                       requestType: .get)
        }
    }
    
    final class GetBannerInput: APIInput {
        init() {
            super.init(urlString: API.Urls.banner, parameters: nil, requestType: .get)
        }
    }
    
    final class GetCinemasInput: APIInput {
        init() {
            super.init(urlString: API.Urls.cinemaList, parameters: nil, requestType: .get)
        }
    }
    
    final class GetBlogInput: APIInput {
        init() {
            super.init(urlString: API.Urls.blogList, parameters: nil, requestType: .get)
        }
    }
}
