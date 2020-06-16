//
//  Constants.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation

enum Constants {
    
    // MARK: - Cases
    case development, production
    
    // MARK: - Properties
    static var current: Constants {
        #if DEVELOPMENT
            return .development
        #else
            return .production
        #endif
    }
    
    var serverURL: String {
        switch self {
        case .development: return "https://newsapi.org/v2"
        case .production: return "https://newsapi.org/v2"
        }
    }
    
    static var apiKey = "e65ee0938a2a43ebb15923b48faed18d"
    
    static var debugNetwork: Bool {
        return true //ProcessInfo.processInfo.environment["DEBUG_NETWORK"] == "enabled"
    }
}
