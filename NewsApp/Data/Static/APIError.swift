//
//  APIError.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case invalidInput, badResposne, badRequest, noConnection
    
    public func toNSError() -> NSError {
        let domain = "com.github.rxswiftcommunity.rxalamofire"
        switch self {
        case .invalidInput:
            return NSError(domain: domain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Input should be a valid number"])
        case .badResposne:
            return NSError(domain: domain, code: -2, userInfo: [NSLocalizedDescriptionKey: "Ошибка сервера"])
        case .badRequest:
            return NSError(domain: domain, code: -3, userInfo: [NSLocalizedDescriptionKey: "Неудалось собрать запрос"])
        case .noConnection:
            return NSError(domain: domain, code: -3, userInfo: [NSLocalizedDescriptionKey: "Отсутствует интернет соединение"])
        }
    }
    
    public static func toNSError(with code: Int) -> NSError {
        let domain = "com.github.rxswiftcommunity.rxalamofire"
        switch code {
        case 1:     return NSError(domain: domain, code: 1, userInfo: [NSLocalizedDescriptionKey: "Ошибка сервера"])
        default:    return NSError(domain: domain, code: -2, userInfo: [NSLocalizedDescriptionKey: "Ошибка сервера"])
        }
    }
    
    public static func toNSError(with description: String) -> NSError {
        let domain = "com.github.rxswiftcommunity.rxalamofire"
        return NSError(domain: domain, code: 1, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
