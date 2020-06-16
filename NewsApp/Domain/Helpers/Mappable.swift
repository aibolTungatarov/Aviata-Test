//
//  Mappable.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation

//swiftlint:disable type_name
public protocol Mappable {
    associatedtype T
    associatedtype U
    
    func from(_ model: T) -> U
    func to(_ model: U) -> T
}
