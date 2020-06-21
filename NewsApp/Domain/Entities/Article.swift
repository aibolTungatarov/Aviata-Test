//
//  Article.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation

public struct Article: Equatable {
    
    public var source: Source?
    public var author: String?
    public var title: String?
    public var description: String?
    public var url: String?
    public var urlToImage: String?
    public var publishedAt: String?
    public var content: String?
    
    public init(
        source: Source?,
        author: String?,
        title: String?,
        description: String?,
        url: String?,
        urlToImage: String?,
        publishedAt: String?,
        content: String?
    ) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    public init() {
        self.source = Source()
        self.author = ""
        self.title = ""
        self.description = ""
        self.url = ""
        self.urlToImage = ""
        self.publishedAt = ""
        self.content = ""
    }
    
    public static func == (lhs: Article, rhs: Article) -> Bool {
        return (lhs.author == rhs.author) &&
            (lhs.title == rhs.title) &&
            (lhs.description == rhs.description) &&
            (lhs.url == rhs.url) &&
            (lhs.urlToImage == rhs.urlToImage) &&
            (lhs.publishedAt == rhs.publishedAt) &&
            (lhs.content == rhs.content)
    }
}
