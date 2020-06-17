//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/17/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Properties
    var lastItem: UITabBarItem?
    private static let kBarHeight: CGFloat = 80
    override var selectedViewController: UIViewController? {
        didSet {
            configureTabBar()
        }
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        configureViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tabBar.frame.size.height = TabBarViewController.kBarHeight
        tabBar.frame.origin.y = view.frame.height - TabBarViewController.kBarHeight
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        tabBar.tintColor = .appOrange
        tabBar.unselectedItemTintColor = .clear
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        tabBar.clipsToBounds = true
        delegate = self
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        
        setViewControllers()
        configureTabBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit \(self)")
    }
}

extension TabBarViewController {
    private func configureViews() {
        view.backgroundColor = .white
    }
}

extension TabBarViewController {
    func setViewControllers() {
        let topHeadlinesVC = TopHeadlinesContainer.shared.controller()
        let everythingVC = .shared.controller()
        viewControllers = [topHeadlinesVC, everythingVC]
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if lastItem == item { return }
        
        UIView.animate(withDuration: 0.4) {
            self.lastItem?.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.lastItem = item
        }
    }
    
}
