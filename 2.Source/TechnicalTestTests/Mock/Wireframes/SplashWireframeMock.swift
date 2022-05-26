//
//  SplashWireframeMock.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

@testable import TechnicalTest

class SplashWireframeMock: SplashWireframeInput {
        
    // MARK: - Spy
    
    var spyShowSplashCalled = false
    var spyShowHomeCalled = false
    
    var spyHeroList: [SuperHero]!
    
    // MARK: - SplashWireframeInput
    
    func showSplash(inNavigation viewController: UINavigationController) {
        self.spyShowSplashCalled = true
    }
    
    func showHome(list: [SuperHero]) {
        self.spyShowHomeCalled = true
        self.spyHeroList = list
    }
}
