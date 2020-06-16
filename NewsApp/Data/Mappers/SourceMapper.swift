//
//  SourceMapper.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import SwiftyJSON

class SourceMapper: Mappable {
    //swiftlint:disable type_name
    typealias T = JSON
    typealias U = Source
    
    enum Key: String, CodingKey {
        case id
        case name
    }
    
    func from(_ model: JSON) -> Source {
        return Source(
            id: model[Key.id.rawValue].intValue,
            name: model[Key.name.rawValue].stringValue
        )
    }
    
    func to(_ model: Source) -> JSON {
        return [
            Key.id.rawValue:    model.id ?? 0,
            Key.name.rawValue:  model.name ?? ""
        ]
    }
}
