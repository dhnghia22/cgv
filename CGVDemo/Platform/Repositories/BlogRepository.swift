//
//  BlogRepository.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

protocol BlogRepositoryType {
    func getBlogDetail(blogId: String) -> Observable<Blog>
}

class BlogRepository: BlogRepositoryType {
    func getBlogDetail(blogId: String) -> Observable<Blog> {
        let input = API.GetBlogDetailInput(blogId: blogId)
        return API.shared.getBlogDetail(input: input)
    }
    
    
}



