//
//  AppDelegate.swift
//  mobile.iOS.test
//
//  Created by Sergey Bondarchuk on 04.02.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootController = FeedViewController()
        let viewController = UINavigationController(rootViewController: rootController)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}
