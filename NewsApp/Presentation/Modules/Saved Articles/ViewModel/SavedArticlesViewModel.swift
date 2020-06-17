//
//  SavedArticlesViewModel.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/15/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

protocol SavedArticlesViewModelInput {
    func viewDidLoad()
}

protocol SavedArticlesViewModelOutput {
    var router: RouterProtocol { get }
    var disposeBag: DisposeBag { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var error: BehaviorRelay<Error> { get }
    var articles: PublishSubject<[ArticleCoreData]> { get set }
}

protocol SavedArticlesViewModelProtocol: SavedArticlesViewModelOutput, SavedArticlesViewModelInput {}

final class SavedArticlesViewModel: SavedArticlesViewModelProtocol {
    // MARK: - OUTPUT
    var router: RouterProtocol
    let disposeBag = DisposeBag()
    var isLoading = BehaviorRelay<Bool>(value: false)
    var error = BehaviorRelay<Error>(value: NSError(domain: "", code: 0))
    let context = AppDelegate.viewContext
    var articles = PublishSubject<[ArticleCoreData]>()
    
    @discardableResult
    init(router: RouterProtocol) {
        self.router = router
    }
    
    private func handle(_ error: Error) {
        self.error.accept(error)
    }
}

// MARK: - INPUT. View event methods
extension SavedArticlesViewModel {
    
    func viewDidLoad() {
        loadArticles()
    }
    
    private func loadArticles() {
        let request: NSFetchRequest<ArticleCoreData> = ArticleCoreData.fetchRequest()
        if let articlesInDB = try? context.fetch(request) {
            var articleList = [ArticleCoreData]()
            for article in articlesInDB {
                articleList.append(article)
            }
            articles.onNext(articleList)
        }
    }
}
