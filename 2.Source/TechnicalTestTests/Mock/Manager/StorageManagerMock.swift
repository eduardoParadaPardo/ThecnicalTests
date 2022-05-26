//
//  StorageManagerMock.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 25/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

@testable import TechnicalTest

class StorageManagerMock: StorageManagerInput {
    
    //MARK: - Spy

    var spyGetSuperHeroesCalled = false
    var spyAddSuperHeroesCalled = false
    
    var spyAddHeroList: [SuperHero]!
    
    // MARK: - Public properties
    
    var getHeroList: [SuperHero]!
    
    // MARK: - StorageManagerInput
    
    func getSuperHeroes() -> [SuperHero] {
        self.spyGetSuperHeroesCalled = true
        return self.getHeroList
    }
    
    func addSuperHeroes(heroList: [SuperHero]) {
        self.spyAddSuperHeroesCalled = true
        self.spyAddHeroList = heroList
    }
}

