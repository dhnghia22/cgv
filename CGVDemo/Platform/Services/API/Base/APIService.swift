//
//  APIService.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 8/31/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


import Alamofire
import RxSwift
import RxAlamofire

func == <K, V>(left: [K:V], right: [K:V]) -> Bool {
    return NSDictionary(dictionary: left).isEqual(to: right)
}

typealias JSONDictionary = [String: Any]

final class API {
    static let shared = API()
    
    
    func requestObject<T: Decodable>(_ input: APIInputBase) -> Observable<T> {
        return request(input)
            .map { json -> T in
                do {
                    let data = try json.covertToData()
                    let t = try JSONDecoder().decode(BaseReponseObjectModel<T>.self, from: data)
                    if let data = t.data {
                        return data
                    } else {
                        throw APIError.invalidResponseData
                    }
                } catch {
                    throw APIError.invalidResponseData
                }
        }
    }
    
    func requestArray<T: Decodable>(_ input: APIInputBase) -> Observable<[T]> {
        return request(input)
            .map { json -> [T] in
                do {
                    let data = try json.covertToData()
                    let t = try JSONDecoder().decode(BaseReponseArrayModel<T>.self, from: data)
                    if let data = t.data {
                        return data
                    } else {
                        throw APIError.invalidResponseData
                    }
                } catch {
                    throw APIError.invalidResponseData
                }
        }
    }
}

// MARK: - Support methods
extension API {
    fileprivate func request(_ input: APIInputBase) -> Observable<JSONDictionary> {
        let urlRequest = /*preprocess(input)
            .do(onNext: { input in
                print(input)
            })*/
             Observable.just(input).flatMapLatest { input in
                Alamofire.SessionManager.default.rx
                    .request(input.requestType,
                             input.urlString,
                             parameters: input.parameters,
                             encoding: input.encoding,
                             headers: input.headers)
            }
            .do(onNext: { (_) in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
            })
            .flatMapLatest { dataRequest -> Observable<(HTTPURLResponse, Data)> in
                return dataRequest
                    //                    .authenticate(user: API.Urls.userAuthen, password: API.Urls.passAuthen)
                    .rx.responseData()
            }
            .do(onNext: { (_) in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }, onError: { (_) in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            })
            .map { (dataResponse) -> JSONDictionary in
                return try self.process(dataResponse)
            }
            .catchError({ [weak self] (error) -> Observable<[String : Any]> in
                guard let _ = self else { return Observable.empty() }
                throw error
            })
        return urlRequest
    }
    
    
    
    fileprivate func upload(_ input: UploadInputBase,
                            data: [UploadData]) -> Observable<JSONDictionary> {
        return /*preprocess(input)
            .do(onNext: { input in
                print(input)
            })*/
            Observable.just(input).flatMapLatest { input in
                Alamofire.SessionManager.default.rx
                    .upload(to: input.urlString,
                            method: input.requestType,
                            headers: input.headers) { (multipartFormData) in
                                if let params = input.parameters {
                                    for (key, value) in params {
                                        if let data = String(describing: value).data(using:.utf8) {
                                            multipartFormData.append(data, withName: key)
                                        }
                                    }
                                }
                                data.forEach({
                                    multipartFormData.append($0.data,
                                                             withName: $0.name,
                                                             fileName: $0.fileName,
                                                             mimeType: $0.mimeType)
                                })
                }
            }
            .do(onNext: { (_) in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
            })
            .flatMapLatest { dataRequest -> Observable<(HTTPURLResponse, Data)> in
                return dataRequest
                    .rx.responseData()
            }
            .do(onNext: { (_) in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }, onError: { (_) in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            })
            .map { (dataResponse) -> JSONDictionary in
                return try self.process(dataResponse)
            }
            .catchError({ [weak self] (error) -> Observable<[String : Any]> in
                guard let _ = self else { return Observable.empty() }
//                if case API.APIError.expiredToken = error,
//                    let token = AuthManager.shared.token {
//                    var newToken = token
//                    newToken.expiryDate = Date().add(components: -1.day)
//                    AuthManager.shared.save(newToken)
//                    return this.upload(input, data: data)
//                }
                throw error
            })
    }
    
    fileprivate func process(_ response: (HTTPURLResponse, Data)) throws -> JSONDictionary {
        let (response, data) = response
        let json: JSONDictionary? = (try? JSONSerialization.jsonObject(with: data, options: [])) as? JSONDictionary
        let error: Error
        switch response.statusCode {
        case 200..<300:
            do {
                print("👍 [\(response.statusCode)] " + (response.url?.absoluteString ?? ""))
                if let json = json, let responseError = try json.parseAPIError(), let _ = responseError.errors {
                    error = APIError.error(response: responseError)
                } else {
                    return json ?? JSONDictionary()
                }
            } catch let err {
                error = APIError.customError(localizeDescription: err.localizedDescription)
            }
        case 401:
            error = APIError.expiredToken
        default:
            do {
                if let json = json, let responseError = try json.parseAPIError() {
                    error = APIError.error(response: responseError)
                } else {
                    error = APIError.unknown(statusCode: response.statusCode)
                }
                print("❌ [\(response.statusCode)] " + (response.url?.absoluteString ?? ""))
            } catch let err {
                error = APIError.customError(localizeDescription: err.localizedDescription)
            }
            if let json = json {
                print(json)
            }
        }
        throw error
    }
    
//    fileprivate func preprocess(_ input: APIInputBase) -> Observable<APIInputBase> {
//        return Observable.deferred {
//            if input.requireAccessToken {
//                return AuthManager.shared.getToken()
//                    .map { accessToken -> APIInputBase in
//                        var headers = input.headers
//                        headers[CommonKey.authorizationKey] = "Bearer \(accessToken)"
//                        input.headers = headers
//                        input.accessToken = accessToken
//                        return input
//                }
//            } else {
//                return Observable.just(input)
//            }
//        }
//    }
}

