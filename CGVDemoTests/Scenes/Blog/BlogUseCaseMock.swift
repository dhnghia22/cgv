//
//  BlogUseCaseMock.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


@testable import CGVDemo

final class BlogUseCaseMock: BlogUseCaseType {
    
    var getBlogCalled = false
    var getBlogReturnValue: Observable<Blog> = Observable.just(Blog.mock())
    func getBlogDetail(blogId: String) -> Observable<Blog> {
        getBlogCalled = true
        return getBlogReturnValue
    }
}
