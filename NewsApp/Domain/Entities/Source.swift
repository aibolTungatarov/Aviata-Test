//
//  Source.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation

public struct Source {

    public var id: Int?
    public var name: String?
    
    public init(
        id: Int?,
        name: String?
    ) {
        self.id = id
        self.name = name
    }
    
    public init() {
        self.id = 0
        self.name = ""
    }
}
