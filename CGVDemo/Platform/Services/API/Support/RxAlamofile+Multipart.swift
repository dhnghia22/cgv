//
//  RxAlamofile+Multipart.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 8/31/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Alamofire
import RxSwift

extension Reactive where Base: SessionManager {
    func upload(to url: URLConvertible,
                method: HTTPMethod = .post,
                headers: HTTPHeaders = [:],
                data: @escaping (MultipartFormData) -> Void) -> Observable<UploadRequest> {
        return Observable.create { observer in
            self.base.upload(multipartFormData: data,
                             to: url,
                             method: method,
                             headers: headers,
                             encodingCompletion: { (result: SessionManager.MultipartFormDataEncodingResult) in
                                switch result {
                                case .failure(let error):
                                    observer.onError(error)
                                case .success(let request, _, _):
                                    observer.onNext(request)
                                    observer.onCompleted()
                                }
            })
            
            return Disposables.create()
        }
    }
}
