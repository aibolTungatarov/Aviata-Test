//
//  TabBar+UITabBar.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/17/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

extension TabBarViewController {
    // MARK: - Constants
    private enum Constant {
        enum Attributes {
            static let `default`: [NSAttributedString.Key: Any] = [.font: FontFamily.Roboto.regular.font(size: 14)!]
            static let selected: [NSAttributedString.Key: Any] = [.font: FontFamily.Roboto.medium.font(size: 14)!]
        }
    }
    
    // MARK: - Methods
    func configureTabBar() {
        guard let selectedViewController = selectedViewController,
            let viewControllers = viewControllers else { return }
        
        for viewController in viewControllers {
            if viewController == selectedViewController {
                viewController.tabBarItem.setTitleTextAttributes(Constant.Attributes.selected, for: .normal)
                self.lastItem = viewController.tabBarItem
            } else {
                viewController.tabBarItem.setTitleTextAttributes(Constant.Attributes.default, for: .normal)
            }
        }
    }
}
