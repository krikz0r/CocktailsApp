//
//  AppDelegate.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = CocktailsListBuilder.start()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }



}

