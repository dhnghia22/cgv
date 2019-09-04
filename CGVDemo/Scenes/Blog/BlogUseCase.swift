//
//  BlogUseCase.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


protocol BlogUseCaseType {
    func getBlogDetail(blogId: String) -> Observable<Blog>
}

struct BlogUseCase: BlogUseCaseType {
    let blogRepository: BlogRepositoryType
    
    func getBlogDetail(blogId: String) -> Observable<Blog> {
        return blogRepository.getBlogDetail(blogId: blogId)
    }
}

