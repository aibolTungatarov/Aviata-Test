//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/15/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol NewsDetailViewModelInput {
    func viewDidLoad()
    func goBack()
//    func changeCoreData(_ isFav: Bool)
}

protocol NewsDetailViewModelOutput {
    var router: RouterProtocol { get }
    var disposeBag: DisposeBag { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var error: BehaviorRelay<Error> { get }
}

protocol NewsDetailViewModelProtocol: NewsDetailViewModelOutput, NewsDetailViewModelInput {}

final class NewsDetailViewModel: NewsDetailViewModelProtocol {
    // MARK: - OUTPUT
    var router: RouterProtocol
    let disposeBag = DisposeBag()
    var isLoading = BehaviorRelay<Bool>(value: false)
    var error = BehaviorRelay<Error>(value: NSError(domain: "", code: 0))
    let context = AppDelegate.viewContext
    
    @discardableResult
    init(router: RouterProtocol) {
        self.router = router
    }
    
    private func handle(_ error: Error) {
        self.error.accept(error)
    }
}

// MARK: - INPUT. View event methods
extension NewsDetailViewModel {
    
    func viewDidLoad() {
        
    }
    
    func goBack() {
        router.dismiss()
    }
}
