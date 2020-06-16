//
//  MainNewsContainer.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Swinject

final class MainNewsContainer {
    
    static let shared = MainNewsContainer()
    
    func container() -> Container {
        let container = Container()
        
//        container.register(CardsUseCaseProtocol.self) { _ in return CardsUseCase(repository: CardRepository()) }
//        container.register(CardsByTagUseCase.self) { _ in return CardsByTagUseCase(repository: CardRepository()) }
        container.register(GetEveryNewsUseCaseProtocol.self) { _ in return GetEveryNewsUseCase(repository: NewsRepository()) }
        container.register(MainNewsRouter.self) { _ in return MainNewsRouter() }
        container.register(MainNewsViewModelProtocol.self) { resolver in
            return MainNewsViewModel(
                router: resolver.resolve(MainNewsRouter.self)!,
                useCase: resolver.resolve(GetEveryNewsUseCaseProtocol.self)!
            )
        }
        container.register(MainViewController.self) { resolver in
            return MainViewController(viewModel: resolver.resolve(MainNewsViewModelProtocol.self)!
            )
        }
        return container
    }
    
    func controller() -> UIViewController {
        guard let controller = container().resolve(MainViewController.self) else {
            return UIViewController()
        }
        return controller
    }
}
