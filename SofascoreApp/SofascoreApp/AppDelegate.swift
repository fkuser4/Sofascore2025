//
//  AppDelegate.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 09.03.2025..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = MainViewController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
}

