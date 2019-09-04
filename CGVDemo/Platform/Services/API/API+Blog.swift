//
//  API+Blog.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

extension API {
    func getBlogDetail(input: GetBlogDetailInput) -> Observable<Blog> {
        return requestObject(input)
    }
}

extension API {
    final class GetBlogDetailInput: APIInput {
        init(blogId: String) {
            super.init(urlString: String(format: API.Urls.blogPostDetail, blogId), parameters: nil, requestType: .get)
        }
    }
}
