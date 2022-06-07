//
//  AppDelegate.swift
//  Voice_copy
//
//  Created by putao on 2022/5/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        var vc = AddDetailViewController()
        var nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        return window
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 1)
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

