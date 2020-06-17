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

protocol AllNewsViewModelInput {
    func viewDidLoad()
}

protocol AllNewsViewModelOutput {
    var router: RouterProtocol { get }
    var disposeBag: DisposeBag { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var error: BehaviorRelay<Error> { get }
}

protocol AllNewsViewModelProtocol: AllNewsViewModelOutput, AllNewsViewModelInput {}

final class AllNewsViewModel: AllNewsViewModelProtocol {
    // MARK: - OUTPUT
    var router: RouterProtocol
    let disposeBag = DisposeBag()
    var isLoading = BehaviorRelay<Bool>(value: false)
    var error = BehaviorRelay<Error>(value: NSError(domain: "", code: 0))
    
    @discardableResult
    init(router: RouterProtocol) {
        self.router = router
    }
    
    private func handle(_ error: Error) {
        self.error.accept(error)
    }
}

// MARK: - INPUT. View event methods
extension AllNewsViewModel {
    
    func viewDidLoad() {
        
    }
}
