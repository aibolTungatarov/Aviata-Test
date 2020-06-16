//
//  ArticleMapper.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import SwiftyJSON

class ArticleMapper: Mappable {
    //swiftlint:disable type_name
    typealias T = JSON
    typealias U = Article
    
    enum Key: String, CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
        case source
    }
    
    func from(_ model: JSON) -> Article {
        return Article(source: model[Key.source.rawValue].object as? Source,
                       author: model[Key.author.rawValue].stringValue,
                       title: model[Key.title.rawValue].stringValue,
                       description: model[Key.description.rawValue].stringValue,
                       url: model[Key.url.rawValue].stringValue,
                       urlToImage: model[Key.urlToImage.rawValue].stringValue,
                       publishedAt: model[Key.publishedAt.rawValue].stringValue,
                       content: model[Key.content.rawValue].stringValue
        )
    }
    
    func to(_ model: Article) -> JSON {
        return [
            Key.author.rawValue:           model.author ?? "",
            Key.source.rawValue:           model.source ?? Source(),
            Key.title.rawValue:            model.title ?? "",
            Key.description.rawValue:      model.description ?? "",
            Key.url.rawValue:              model.url ?? "",
            Key.urlToImage.rawValue:       model.urlToImage ?? "",
            Key.publishedAt.rawValue:      model.publishedAt ?? "",
            Key.content.rawValue:          model.content ?? ""
        ]
    }
}
