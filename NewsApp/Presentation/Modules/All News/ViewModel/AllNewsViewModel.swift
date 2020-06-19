//
//  MainNewsViewModel.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AllNewsViewModelInput {
    func viewDidLoad()
    func goToDetail(with article: Article?)
}

protocol AllNewsViewModelOutput {
    var router: RouterProtocol { get }
    var disposeBag: DisposeBag { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var error: BehaviorRelay<Error> { get }
    var news: PublishSubject<News> { get set }
    var useCase: GetEveryNewsUseCaseProtocol { get set }
}

protocol AllNewsViewModelProtocol: AllNewsViewModelOutput, AllNewsViewModelInput {}

final class AllNewsViewModel: AllNewsViewModelProtocol {
    
    // MARK: - OUTPUT
    var router: RouterProtocol
    let disposeBag = DisposeBag()
    var isLoading = BehaviorRelay<Bool>(value: false)
    var news = PublishSubject<News>()
    var error = BehaviorRelay<Error>(value: NSError(domain: "", code: 0))
    var useCase: GetEveryNewsUseCaseProtocol
    
    @discardableResult
    init(router: RouterProtocol, useCase: GetEveryNewsUseCaseProtocol) {
        self.useCase = useCase
        self.router = router
    }
    
    private func handle(_ error: Error) {
        self.error.accept(error)
    }
}

// MARK: - INPUT. View event methods
extension AllNewsViewModel {
    
    func viewDidLoad() {
        getEverything()
//        repeatRequest()
    }
    
    @objc func getEverything() {
        useCase.execute(query: "Apple")
            .subscribe(onNext: { (news) in
                self.news.onNext(news)
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                self.handle(error)
            }
        ).disposed(by: disposeBag)
    }
    
    func repeatRequest() {
        _ = Timer.scheduledTimer(timeInterval: 5, target: self,selector: Selector(("getEverything")), userInfo: nil, repeats: true)
    }
    
    func goToDetail(with article: Article?) {
        let context = AllNewsRouter.RouteType.detail(article: article)
        router.enqueueRoute(with: context)
    }
}
