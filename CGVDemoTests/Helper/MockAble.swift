//
//  MockAble.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo

protocol MockAble {
    static func mock() -> Self
}
class MockRepository<T: MockAble & Equatable> {
    var objects: [T] = []
    
    func get() -> Observable<[T]> {
        objects = (0..<10).map { _ in T.mock() }
        return Observable.just(objects)
    }
    
    func getMore() -> Observable<[T]> {
        let more = (0..<10).map { _ in T.mock() }
        objects += more
        return Observable.just(more)
    }
}
