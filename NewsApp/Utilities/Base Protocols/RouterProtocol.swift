//
//  RouterProtocol.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

protocol RouterProtocol: class {
    
    var baseViewController: UIViewController? { get set }
    
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?)
    func enqueueRoute(with context: Any?, animated: Bool)
    func dismiss(with context: Any?, animated: Bool)
    func dismiss(animated: Bool)
}

extension RouterProtocol {
    
    // MARK: - Router default methods
    func present(on baseViewController: UIViewController, context: Any?) {
        present(on: baseViewController, animated: true, context: context)
    }
    
    func enqueueRoute(with context: Any?) {
        enqueueRoute(with: context, animated: true)
    }
    
    func dismiss() {
        dismiss(animated: true)
    }
    
    func dismiss(with context: Any?, animated: Bool) {
        dismiss(animated: animated)
    }
}
