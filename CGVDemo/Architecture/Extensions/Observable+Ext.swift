//
//  Observable+Ext.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

extension ObservableType where Element == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
}

extension ObservableType {
    // swiftlint:disable:next missing_docs
    public func unwrap<T>() -> Observable<T> where Element == T? {
        
        return self
            .filter { value in
                if case .some = value {
                    return true
                }
                return false
                // swiftlint:disable:next force_unwrapping
            }.map { $0! }
    }
}

extension SharedSequenceConvertibleType {
    
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
    
    func mapToOptional() -> SharedSequence<SharingStrategy, Element?> {
        return map { value -> Element? in value }
    }
    
    // swiftlint:disable:next missing_docs
    public func unwrap<T>() -> SharedSequence<SharingStrategy, T> where Element == T? {
        return self
            .filter { value in
                if case .some = value {
                    return true
                }
                return false
                // swiftlint:disable:next force_unwrapping
            }.map { $0! }
    }
}

extension ObservableType {
    
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    func mapToOptional() -> Observable<Element?> {
        return map { value -> Element? in value }
    }
}

fileprivate func getThreadName() -> String {
    if Thread.current.isMainThread {
        return "Main Thread"
    } else if let name = Thread.current.name {
        if name == "" {
            return "Anonymous Thread"
        }
        return name
    } else {
        return "Unknown Thread"
    }
}

extension ObservableType {
    func dump() -> Observable<Self.Element> {
        return self.do(onNext: { element in
            let threadName = getThreadName()
            print("[D] \(element) received on \(threadName)")
        })
    }
    
    func dumpingSubscription() -> Disposable {
        return self.subscribe(onNext: { element in
            let threadName = getThreadName()
            print("[S] \(element) received on \(threadName)")
        })
    }
}


