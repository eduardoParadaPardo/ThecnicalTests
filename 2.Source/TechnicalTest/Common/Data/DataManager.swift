//
//  DataManager.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 23/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

enum SuperHeroResult {
    case success(list: [SuperHero])
    case error(error: TTError)
}

protocol DataManagerOutput: AnyObject {
    func fetchSuperHeroesDidFinish(result: SuperHeroResult)
}
 
protocol DataManagerInput {
    func fetchSuperHeroes()
    func fetchSuperHero(id: String)
    func saveSuperHeroes(list: [SuperHero])
}

class DataManager {
    
    // MARK: - Public properties
    
    weak var output: DataManagerOutput?
    
    // MARK: - Private properties
    
    private let servicesManager: ServicesManagerInput
    private let storageManager: StorageManagerInput
    
    init(servicesManager: ServicesManagerInput, storageManager: StorageManagerInput) {
        self.servicesManager = servicesManager
        self.storageManager = storageManager
    }
}

// MARK: - DataManagerInput

extension DataManager: DataManagerInput {
    
    func fetchSuperHeroes() {
        let superHeroList = self.storageManager.getSuperHeroes()
        if superHeroList.isEmpty {
            self.servicesManager.fetchSuperHeroes()
        } else {
            self.output?.fetchSuperHeroesDidFinish(result: .success(list: superHeroList))
        }        
    }
    
    func fetchSuperHero(id: String) {
        self.servicesManager.fetchSuperHero(id: id)
    }
    
    func saveSuperHeroes(list: [SuperHero]) {
        self.storageManager.addSuperHeroes(heroList: list)
    }
}

// MARK: - DataManagerInput

extension DataManager: ServicesManagerOutput {

    func fetchSuperHeroDidFinsh(result: ServiceResult<Any>) {
        switch result {
        case .success(let dict):
            let json = JSON(from: dict)
            let superHeroList = SuperHero.parseList(json: json)
            self.output?.fetchSuperHeroesDidFinish(result: .success(list: superHeroList))
        case .error(let error):
            self.output?.fetchSuperHeroesDidFinish(result: .error(error: error))
        }
    }
}
