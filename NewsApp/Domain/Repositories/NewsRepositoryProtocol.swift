//
//  NewsRepositoryProtocol.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

public protocol NewsRepositoryProtocol {
    func getTopHeadlines(query: String) -> Observable<News>
    func getEverything(query: String) -> Observable<News>
}
