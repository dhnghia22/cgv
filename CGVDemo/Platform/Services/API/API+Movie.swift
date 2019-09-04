//
//  API+Movie.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

extension API {
    final class GetMovieInput: APIInput {
        init(id: String) {
            let urlString = String(format: API.Urls.movieDetail, id)
            super.init(urlString: urlString, parameters: nil, requestType: .get)
        }
    }
}
