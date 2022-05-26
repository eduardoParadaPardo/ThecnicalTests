//
//  AppWireframe.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

protocol AppWireframeProtocol {
    func showSplash()
}

class AppWireframe {
    var window: UIWindow?
    var navigationController = UINavigationController()
}

// MARK: - AppControllerProtocol

extension AppWireframe: AppWireframeProtocol {
    
    func showSplash() {
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
        
        let splashWireframe = SplashWireframe()
        splashWireframe.showSplash(inNavigation: navigationController)
        self.window?.rootViewController = self.navigationController
    }
}
