//
//  APIInput.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 8/31/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


import Alamofire


class APIInputBase {
    var headers: [String: String] = [:]
    let urlString: String
    let requestType: HTTPMethod
    let encoding: ParameterEncoding
    let parameters: [String: Any]?
//    let requireAccessToken: Bool
    var accessToken: String?
    var useCache: Bool = false {
        didSet {
            if requestType == .get {
                fatalError("Do not use cache")
            }
        }
    }
    var user: String?
    var password: String?
    
    init(urlString: String,
         parameters: [String: Any]?,
         requestType: HTTPMethod) {
        self.urlString = urlString
        self.parameters = parameters
        self.requestType = requestType
        self.encoding = requestType == .get ? URLEncoding.default : JSONEncoding.default
//        self.requireAccessToken = requireAccessToken
    }
}

extension APIInputBase: CustomStringConvertible {
    var urlEncodingString: String {
        guard
            let url = URL(string: urlString),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let parameters = parameters,
            requestType == .get
            else {
                return urlString
        }
        urlComponents.queryItems = parameters.map {
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
        return urlComponents.url?.absoluteString ?? urlString
    }
    
    var description: String {
        if requestType == .get {
            return [
                "🌎 \(requestType.rawValue) \(urlEncodingString)"
                ].joined(separator: "\n")
        }
        return [
            "🌎 \(requestType.rawValue) \(urlString) \(headers.values)",
            "Parameters: \(String(describing: parameters ?? JSONDictionary()))"
            ].joined(separator: "\n")
    }
}

// MARK: - Upload
extension API {
    struct UploadData {
        let data: Data
        let name: String
        let fileName: String
        let mimeType: String
    }
    
    class UploadInputBase: APIInput {
        let data: [UploadData]
        
        init(data: [UploadData],
             urlString: String,
             parameters: [String: Any]?,
             requestType: HTTPMethod,
             requireAccessToken: Bool = true,
             useCache: Bool = false) {
            
            self.data = data
            
            super.init(urlString: urlString,
                       parameters: parameters,
                       requestType: requestType)
        }
    }
}


class APIInput: APIInputBase {
    override init(urlString: String, parameters: [String : Any]?,
                  requestType: HTTPMethod) {
        super.init(urlString: urlString,
                   parameters: parameters,
                   requestType: requestType)
//        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        self.headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
        ]
        
//        #if DEVELOP_DEBUG || DEVELOP_RELEASE || STAGING_DEBUG || STAGING_RELEASE
//        self.headers[CommonKey.basicAuthenKey] = CommonKey.basicAuthenValue
//        #endif
        
        self.user = nil
        self.password = nil
    }
}

