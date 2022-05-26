//
//  SplashInteractor.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 23/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

protocol SplashInteractorOutput: AnyObject {
    func showHome(list: [SuperHero])
    func showError(text: String)
}

protocol SplashInteractorInput {
    func loadInformation()
}

class SplashInteractor {
    
    // MARK: - Interactor output
    
    weak var output: SplashInteractorOutput?

    // MARK: - Private properties
    
    private let dataManager: DataManagerInput
    
    init(dataManager: DataManagerInput) {
        self.dataManager = dataManager
    }
}

// MARK: - SplashInteractornput

extension SplashInteractor: SplashInteractorInput {
    
    func loadInformation() {
        self.dataManager.fetchSuperHeroes()
    }
}

// MARK: - DataManagerOutput

extension SplashInteractor: DataManagerOutput {
    
    func fetchSuperHeroesDidFinish(result: SuperHeroResult) {
        switch result {
        case .success(let list):
            self.dataManager.saveSuperHeroes(list: list)
            self.output?.showHome(list: list)
        case .error(let error):
            self.output?.showError(text: error.text)
        }
    }
}
