//
//  AllNewsViewModel.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/17/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TopHeadlinesViewModelInput {
    func viewDidLoad()
    func goToDetail(with article: Article?)
    func loadNews(at page: Int)
}

protocol TopHeadlinesViewModelOutput {
    var router: RouterProtocol { get }
    var disposeBag: DisposeBag { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var error: BehaviorRelay<Error> { get }
    var useCase: GetTopHeadlinesUseCaseProtocol { get set }
    var news: PublishSubject<News> { get set }
}

protocol TopHeadlinesViewModelProtocol: TopHeadlinesViewModelInput, TopHeadlinesViewModelOutput {}

final class TopHeadlinesViewModel: TopHeadlinesViewModelProtocol {
    // MARK: - OUTPUT
    var router: RouterProtocol
    let disposeBag = DisposeBag()
    var isLoading = BehaviorRelay<Bool>(value: false)
    var error = BehaviorRelay<Error>(value: NSError(domain: "", code: 0))
    var news = PublishSubject<News>()
    var useCase: GetTopHeadlinesUseCaseProtocol
    var page = 1
    
    @discardableResult
    init(router: RouterProtocol, useCase: GetTopHeadlinesUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
    }
    
    private func handle(_ error: Error) {
        self.error.accept(error)
    }
}

// MARK: - INPUT. View event methods
extension TopHeadlinesViewModel {
    
    func viewDidLoad() {
        getTopHeadlines()
//        repeatRequest()
    }
    
    @objc func getTopHeadlines() {
        isLoading.accept(true)
        useCase.execute(query: "USA", page: page)
            .subscribe(onNext: { (news) in
                self.news.onNext(news)
                self.isLoading.accept(false)
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                self.handle(error)
            }
        ).disposed(by: disposeBag)
    }
    
    @objc func repeatGetTopHeadlines() {
        getTopHeadlines()
    }
    
    func repeatRequest() {
        _ = Timer.scheduledTimer(timeInterval: 5, target: self,selector: Selector(("repeatGetTopHeadlines")), userInfo: nil, repeats: true)
    }
    
    func goToDetail(with article: Article?) {
        let context = TopHeadlinesRouter.RouteType.detail(article: article)
        router.enqueueRoute(with: context)
    }
    
    func loadNews(at page: Int) {
        self.page = page
        getTopHeadlines()
    }
}
