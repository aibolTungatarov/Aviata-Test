//
//  URL.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

extension URL {
    
    // MARK: - Main
    private static let serverURL = Constants.current.serverURL
    
    // MARK: - About App
    static let siteURL = URL(string: "https://newsapi.org/v2")!
    
    // MARK: - Auth Flow
    static let everything = URL(string: serverURL + "/everything")!
    static let topHeadlines = URL(string: serverURL + "/top-headlines")!
}

extension URL {
    func getQueryParameter(_ param: String) -> String? {
      guard let url = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
