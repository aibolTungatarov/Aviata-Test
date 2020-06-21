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
        container.register(TopHeadlinesRouter.self) { _ in return TopHeadlinesRouter() }
        container.register(TopHeadlinesViewModelProtocol.self) { resolver in
            return TopHeadlinesViewModel(
                router: resolver.resolve(TopHeadlinesRouter.self)!,
                useCase: resolver.resolve(GetTopHeadlinesUseCaseProtocol.self)!
            )
        }
        container.register(TopHeadlinesViewController.self) { resolver in
            return TopHeadlinesViewController(viewModel: resolver.resolve(TopHeadlinesViewModelProtocol.self)!
            )
        }
        return container
    }
    
    func controller() -> UINavigationController {
        guard let controller = container().resolve(TopHeadlinesViewController.self) else {
            return UINavigationController()
        }
        controller.tabBarItem = UITabBarItem(title: "Top Headlines", image: Asset.homeImage.image, selectedImage: Asset.homeImage.image)
        return UINavigationController(rootViewController: controller)
    }
}
