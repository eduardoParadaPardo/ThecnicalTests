//
//  SplashViewMock.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

@testable import TechnicalTest

class HomeViewMock: UIViewController, HomePresenterOutput {
    
    //MARK: - Spy
    
    var spyShowSuperHeroListCalled = false
    
    var spyList: [SuperHero]!
    
    // MARK: - HomePresenterOutput
    
    func showSuperHeroList(with list: [SuperHero]) {
        self.spyList = list
        self.spyShowSuperHeroListCalled = true
    }
}
