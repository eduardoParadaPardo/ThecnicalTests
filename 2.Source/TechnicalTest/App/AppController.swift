//
//  AppController.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

protocol AppControllerProtocol {
    func appDidLaunch(_ application: UIApplication)
}

class AppController {
    
    // MARK: - Singleton
    
    static let shared = AppController()
    
    // MARK: - Public properties
    
    var appWireframe: AppWireframe?
}

// MARK: - AppControllerProtocol

extension AppController: AppControllerProtocol {
    
    func appDidLaunch(_ application: UIApplication) {
        
        // Setup initial configuration
        
        self.appWireframe?.showSplash()
    }
}
