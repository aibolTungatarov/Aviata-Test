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
        container.register(GetEveryNewsUseCaseProtocol.self) { _ in return GetEveryNewsUseCase(repository: NewsRepository()) }
        container.register(AllNewsRouter.self) { _ in return AllNewsRouter() }
        container.register(AllNewsViewModelProtocol.self) { resolver in
            return AllNewsViewModel(
                router: resolver.resolve(AllNewsRouter.self)!,
                useCase: resolver.resolve(GetEveryNewsUseCaseProtocol.self)!
            )
        }
        container.register(AllNewsViewController.self) { resolver in
            return AllNewsViewController(viewModel: resolver.resolve(AllNewsViewModelProtocol.self)!
            )
        }
        return container
    }
    
    func controller() -> UINavigationController {
        guard let controller = container().resolve(AllNewsViewController.self) else {
            return UINavigationController()
        }
        let tabBarItem = UITabBarItem(title: "All News", image: Asset.newsIcon.image, selectedImage: Asset.newsIcon.image)
        tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -8, right: 0)
        controller.tabBarItem = tabBarItem
        return UINavigationController(rootViewController: controller)
    }
}
