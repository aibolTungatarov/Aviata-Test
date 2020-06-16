//
//  NewsMapper.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsMapper: Mappable {
    //swiftlint:disable type_name
    typealias T = JSON
    typealias U = News
    
    enum Key: String, CodingKey {
        case status
        case totalResults
        case articles
    }
    
    func from(_ model: JSON) -> News {
        let jsonList = model[Key.articles.rawValue].arrayValue
        var list = [Article]()
        for json in jsonList {
            let entity = ArticleMapper().from(json)
            list.append(entity)
        }
        return News(
            status: model[Key.status.rawValue].stringValue,
            totalResults: model[Key.totalResults.rawValue].intValue,
            articles: list
        )
    }
    
    func to(_ model: News) -> JSON {
        return [
            Key.status.rawValue:           model.status ?? "",
            Key.totalResults.rawValue:     model.totalResults ?? 0,
            Key.articles.rawValue:         model.articles
        ]
    }
}
