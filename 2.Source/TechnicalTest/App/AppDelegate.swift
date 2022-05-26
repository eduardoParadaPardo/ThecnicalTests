//
//  AppDelegate.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appController = AppController.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.prepareAppController(application)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }

    // MARK: - Private method
    
    private func prepareAppController(_ application: UIApplication) {
        let appController = AppController.shared
        appController.appWireframe = AppWireframe()
        appController.appWireframe?.window = self.window
        appController.appDidLaunch(application)
    }
}
