//
//  MainNewsContainer.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Swinject

final class TopHeadlinesContainer {
    
    static let shared = TopHeadlinesContainer()
    
    func container() -> Container {
        let container = Container()
        
//        container.register(CardsUseCaseProtocol.self) { _ in return CardsUseCase(repository: CardRepository()) }
//        container.register(CardsByTagUseCase.self) { _ in return CardsByTagUseCase(repository: CardRepository()) }
        container.register(GetTopHeadlinesUseCaseProtocol.self) { _ in return GetTopHeadlinesUseCase(repository: NewsRepository()) }
        container.register(TopHeadlinesNewsRouter.self) { _ in return TopHeadlinesNewsRouter() }
        container.register(TopHeadlinesViewModelProtocol.self) { resolver in
            return TopHeadlinesViewModel(
                router: resolver.resolve(TopHeadlinesNewsRouter.self)!,
                useCase: resolver.resolve(GetTopHeadlinesUseCaseProtocol.self)!
            )
        }
        container.register(TopHeadlinesViewController.self) { resolver in
            return TopHeadlinesViewController(viewModel: resolver.resolve(TopHeadlinesViewModelProtocol.self)!
            )
        }
        return container
    }
    
    func controller() -> UIViewController {
        guard let controller = container().resolve(TopHeadlinesViewController.self) else {
            return UIViewController()
        }
        return controller
    }
}
