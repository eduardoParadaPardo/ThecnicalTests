//
//  DetailViewMock.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 26/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import UIKit

@testable import TechnicalTest

class DetailVCMock: UIViewController, DetailPresenterOutput {
    
    //MARK: - Spy
    
    var spyUpdateLoadingCalled = false
    var spyShowErrorCalled = false
    var spyShowSuperHeroCalled = false
    
    var spyHero: SuperHero!
    var spyShow: Bool!
    var spyTextError: String!
    
    // MARK: - DetailPresenterOutput
    
    func updateLoading(show: Bool) {
        self.spyShow = show
        self.spyUpdateLoadingCalled = true
    }
    
    func showError(text: String) {
        self.spyTextError = text
        self.spyShowErrorCalled = true
    }
    
    func showSuperHero(with hero: SuperHero) {
        self.spyHero = hero
        self.spyShowSuperHeroCalled = true
    }
}
