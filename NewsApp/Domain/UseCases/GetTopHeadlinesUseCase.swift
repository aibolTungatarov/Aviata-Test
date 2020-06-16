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
    func execute() -> Observable<News>
}

public final class GetTopHeadlinesUseCase: GetTopHeadlinesUseCaseProtocol {

    private let repository: NewsRepositoryProtocol

    public init(repository: NewsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() -> Observable<News> {
        return repository.getTopHeadlines()
    }
}
