//
//  AllNewsContainer.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/17/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Swinject

final class AllNewsContainer {
    
    static let shared = AllNewsContainer()
    
    func container() -> Container {
        let container = Container()
        
//        container.register(CardsUseCaseProtocol.self) { _ in return CardsUseCase(repository: CardRepository()) }
//        container.register(CardsByTagUseCase.self) { _ in return CardsByTagUseCase(repository: CardRepository()) }
//        container.register(GetEveryNewsUseCaseProtocol.self) { _ in return GetEveryNewsUseCase(repository: NewsRepository()) }
        container.register(AllNewsRouter.self) { _ in return AllNewsRouter() }
        container.register(AllNewsViewModelProtocol.self) { resolver in
            return AllNewsViewModel(
                router: resolver.resolve(AllNewsRouter.self)!
            )
        }
        container.register(AllNewsViewController.self) { resolver in
            return AllNewsViewController(viewModel: resolver.resolve(AllNewsViewModelProtocol.self)!
            )
        }
        return container
    }
    
    func controller() -> UIViewController {
        guard let controller = container().resolve(AllNewsViewController.self) else {
            return UIViewController()
        }
        return controller
    }
}
