//
//  HomeWireframeMock.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

@testable import TechnicalTest

class HomeWireframeMock: HomeWireframeInput {
    
    // MARK: - Spy
    
    var spyShowHomeCalled = false
    var spyShowDetailCalled = false
    
    var spyHero: SuperHero!
    
    // MARK: - HomeWireframeInput
        
    func showHome(inNavigation viewController: UINavigationController, list: [SuperHero]) {
        self.spyShowHomeCalled = true
    }
    
    func showDetail(hero: SuperHero) {
        self.spyShowDetailCalled = true
        self.spyHero = hero
    }
}

