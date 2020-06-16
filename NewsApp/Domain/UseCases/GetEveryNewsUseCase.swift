//
//  GetEveryNewsUseCase.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import RxSwift

public protocol GetEveryNewsUseCaseProtocol {
    func execute(query: String) -> Observable<News>
}

public final class GetEveryNewsUseCase: GetEveryNewsUseCaseProtocol {

    private let repository: NewsRepositoryProtocol

    public init(repository: NewsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(query: String) -> Observable<News> {
        return repository.getEverything(query: query)
    }
}
