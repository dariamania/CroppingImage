//
//  AppDelegate.swift
//  CroppingImage
//
//  Created by Dariia Pavlovskaya on 17.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .purple
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

