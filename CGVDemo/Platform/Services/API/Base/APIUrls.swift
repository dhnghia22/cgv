//
//  APIUrls.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 8/31/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

extension API {
    struct Urls {
        static var domainURL: String = "https://www.cgv.vn"
        static var baseURL: String { return domainURL + "/en/api" }
        static var refreshToken: String { return baseURL + "/refresh_tokens" }
        
        // MARK: - Authentication
        static var login: String { return baseURL + "customer/login" }

        // MARK: - API for app
        static var listSneakShow: String { return baseURL + "/movie/listSneakShow" }
        static var blogList: String { return baseURL + "/blog/list" }
        static var cinemaList: String { return baseURL + "/cinema/list" }
        static var banner: String { return baseURL + "/common/banners" }
        static var movieDetail: String { return baseURL + "/movie/movie/id/%@" }
        static var blogPostDetail: String { return baseURL + "/blog/post/id/%@" }
        static var showTime: String { return baseURL + "/movie/showtimes/sku/%@/date/%@" }
    }
}
