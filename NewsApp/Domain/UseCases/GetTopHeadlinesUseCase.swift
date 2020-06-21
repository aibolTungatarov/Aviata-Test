//
//  GetTopHeadlinesUseCase.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import RxSwift

public protocol GetTopHeadlinesUseCaseProtocol {
    func execute(query: String, page: Int) -> Observable<News>
}

public final class GetTopHeadlinesUseCase: GetTopHeadlinesUseCaseProtocol {

    private let repository: NewsRepositoryProtocol

    public init(repository: NewsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(query: String, page: Int) -> Observable<News> {
        return repository.getTopHeadlines(query: query, page: page)
    }
}
