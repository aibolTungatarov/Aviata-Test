//
//  SavedArticlesContainer.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/15/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Swinject

final class SavedArticlesContainer {
    
    static let shared = SavedArticlesContainer()
    
    func container() -> Container {
        let container = Container()
        
//        container.register(CardsUseCaseProtocol.self) { _ in return CardsUseCase(repository: CardRepository()) }
//        container.register(CardsByTagUseCase.self) { _ in return CardsByTagUseCase(repository: CardRepository()) }
//        container.register(GetEveryNewsUseCaseProtocol.self) { _ in return GetEveryNewsUseCase(repository: NewsRepository()) }
        container.register(SavedArticlesRouter.self) { _ in return SavedArticlesRouter() }
        container.register(SavedArticlesViewModelProtocol.self) { resolver in
            return SavedArticlesViewModel(
                router: resolver.resolve(SavedArticlesRouter.self)!
            )
        }
        container.register(SavedArticlesViewController.self) { resolver in
            return SavedArticlesViewController(viewModel: resolver.resolve(SavedArticlesViewModelProtocol.self)!
            )
        }
        return container
    }
    
    func controller() -> UINavigationController {
        guard let controller = container().resolve(SavedArticlesViewController.self) else {
            return UINavigationController()
        }
        let tabBarItem = UITabBarItem(title: "Saved Articles", image: Asset.bookmarkImage.image, selectedImage: Asset.bookmarkImage.image)
        tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -8, right: 0)
        controller.tabBarItem = tabBarItem
        return UINavigationController(rootViewController: controller)
    }
}
