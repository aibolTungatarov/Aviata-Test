//
//  NewsDetailContainer.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/15/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Swinject

final class NewsDetailContainer {
    
    static let shared = NewsDetailContainer()
    
    func container(_ article: Article?) -> Container {
        let container = Container()
        
//        container.register(CardsUseCaseProtocol.self) { _ in return CardsUseCase(repository: CardRepository()) }
//        container.register(CardsByTagUseCase.self) { _ in return CardsByTagUseCase(repository: CardRepository()) }
//        container.register(GetEveryNewsUseCaseProtocol.self) { _ in return GetEveryNewsUseCase(repository: NewsRepository()) }
        container.register(NewsDetailRouter.self) { _ in return NewsDetailRouter() }
        container.register(NewsDetailViewModelProtocol.self) { resolver in
            return NewsDetailViewModel(
                router: resolver.resolve(NewsDetailRouter.self)!
            )
        }
        container.register(NewsDetailViewController.self) { resolver in
            return NewsDetailViewController(viewModel: resolver.resolve(NewsDetailViewModelProtocol.self)!,
                                            article: article
            )
        }
        return container
    }
    
    func controller(_ article: Article?) -> UIViewController {
        guard let controller = container(article).resolve(NewsDetailViewController.self) else {
            return UIViewController()
        }
        return controller
    }
}
