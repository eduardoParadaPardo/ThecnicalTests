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
    
    // MARK: - Handler Error
    
    private func handleError(error: Error) {
        if let error = error as? TTError {
            self.output?.fetchSuperHeroesDidFinish(result: .error(error: error))
        } else {
            self.output?.fetchSuperHeroesDidFinish(result: .error(error: TTError(type: .generalError)))
        }
    }
}

// MARK: - DataManagerInput

extension DataManager: DataManagerInput {
    
    func fetchSuperHeroes() {
        do {
            let superHeroList = try self.storageManager.getSuperHeroes()
            if superHeroList.isEmpty {
                self.servicesManager.fetchSuperHeroes()
            } else {
                self.output?.fetchSuperHeroesDidFinish(result: .success(list: superHeroList))
            }
        } catch {
            self.handleError(error: error)
        }
    }
    
    func fetchSuperHero(id: String) {
        self.servicesManager.fetchSuperHero(id: id)
    }
    
    func saveSuperHeroes(list: [SuperHero]) {
        do {
            try self.storageManager.addSuperHeroes(heroList: list)
        } catch {
            // TODO
            print(error.localizedDescription)
        }
    }
}

// MARK: - DataManagerInput

extension DataManager: ServicesManagerOutput {

    func fetchSuperHeroDidFinsh(result: ServiceResult<Any>) {
        switch result {
        case .success(let dict):
            let json = JSON(from: dict)
            do {
                let superHeroList = try SuperHero.parseList(json: json)
                self.output?.fetchSuperHeroesDidFinish(result: .success(list: superHeroList))
            } catch {
                self.handleError(error: error)
            }

        case .error(let error):
            self.output?.fetchSuperHeroesDidFinish(result: .error(error: error))
        }
    }
}
