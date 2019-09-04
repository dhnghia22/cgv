//
//  APIError.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 8/31/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


extension API {
    
    enum APIError: Error, CustomStringConvertible {
        case noStatusCode
        case invalidResponseData
        case unknown(statusCode: Int)
        case error(response: ResponseError)
        case invalidToken
        case expiredToken
        case customError(localizeDescription: String)
        
        var description: String {
            switch self {
            case let .unknown(code):
                return "Unknow error" + " \(code)"
            case .invalidResponseData:
                return "Invalid response data"
            case let .error(response):
                if let errors = response.errors, errors.count > 0 {
                    return errors[0].detail ?? "Unknow error"
                } else {
                    return "Unknow error"
                }
            case .invalidToken:
                return "Invalid access token"
            case let .customError(localizeDescription):
                return localizeDescription
            default:
                return "Unknow error"
            }
        }
        
        var code: Int {
            switch self {
            case let .error(response):
                if let errors = response.errors, errors.count > 1 {
                    return errors[0].code ?? 0
                } else {
                    return 0
                }
            default:
                return 0
            }
        }
    }
}

class ResponseError: Decodable {
    var errors: [ErrorDetail]?
}

class ErrorDetail: Decodable {
    var code: Int?
    var detail: String?
}

