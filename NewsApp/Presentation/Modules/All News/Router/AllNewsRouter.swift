//
//  AllNewsRouter.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/17/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

class AllNewsRouter: RouterProtocol {
    
    // MARK: - Enums
    enum PresentationContext {
        case `default`
    }
    
    enum RouteType {
        case subCategory(categoryString: String)
    }
    
    // MARK: - Properties
    weak var baseViewController: UIViewController?
    
    // MARK: - Methods
    func present(on baseVC: UIViewController, animated: Bool, context: Any?) {
        guard let context = context as? PresentationContext else {
            assertionFailure("The context type mismatch")
            return
        }
        
        guard let navigationController = baseVC.navigationController else {
            assertionFailure("Navigation controller is not set")
            return
        }
        
        baseViewController = baseVC

        switch context {
        case .default:
            let viewController = AllNewsContainer.shared.controller()
            viewController.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                navigationController.pushViewController(viewController, animated: animated)
            }
        }
    }
    
    func enqueueRoute(with context: Any?, animated: Bool) { }
    
    func dismiss(with context: Any?, animated: Bool) { }
    
    func dismiss(animated: Bool) { }
}
