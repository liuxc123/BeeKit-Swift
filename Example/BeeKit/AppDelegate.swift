//
//  AppDelegate.swift
//  BeeKit
//
//  Created by liuxc123 on 08/25/2021.
//  Copyright (c) 2021 liuxc123. All rights reserved.
//

import UIKit
import CatalogByConvention

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let rootViewController = CBCNodeListViewController(node: CBCCreateNavigationTree())
        rootViewController.title = "Catalog by Convention"
          
        let navController = UINavigationController(rootViewController: rootViewController)
        self.window?.rootViewController = navController
          
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

