//
//  News.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation

public struct News {

    public var status: String?
    public var totalResults: Int?
    public var articles: [Article]
    
    public init(
        status: String?,
        totalResults: Int?,
        articles: [Article]
    ) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}
