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
}

protocol TopHeadlinesViewModelOutput {
    var router: RouterProtocol { get }
    var disposeBag: DisposeBag { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var error: BehaviorRelay<Error> { get }
    var useCase: GetTopHeadlinesUseCaseProtocol { get set }
}

protocol TopHeadlinesViewModelProtocol: TopHeadlinesViewModelInput, TopHeadlinesViewModelOutput {}

final class TopHeadlinesViewModel: TopHeadlinesViewModelProtocol {
    // MARK: - OUTPUT
    var router: RouterProtocol
    let disposeBag = DisposeBag()
    var isLoading = BehaviorRelay<Bool>(value: false)
    var error = BehaviorRelay<Error>(value: NSError(domain: "", code: 0))
    var useCase: GetTopHeadlinesUseCaseProtocol
    
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
        
    }
}
