//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/13/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        confugureInitialViewController()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func confugureInitialViewController() {
//        let headlineItem = UITabBarItem()
//        headlineItem.title = "Top Headlines"
//        headlineItem.image = Asset.homeImage.image
//        let mainVC = UINavigationController(rootViewController: MainNewsContainer.shared.controller())
//        mainVC.tabBarItem = headlineItem
//
//        let savedItem = UITabBarItem()
//        savedItem.title = "Saved"
//        savedItem.image = Asset.bookmarkImage.image
//        let savedVC = UINavigationController(rootViewController: SavedArticlesContainer.shared.controller())
//        savedVC.tabBarItem = savedItem
//
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [mainVC, savedVC]
//        window?.rootViewController = tabBarController
        
        let tabBarController = TabBarViewController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

