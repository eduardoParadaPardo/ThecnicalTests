//
//  DetailInteractor.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 24/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

protocol DetailInteractorOutput: AnyObject {
    func showSuperHero(with hero: SuperHero)
    func showError(text: String)
}
    
protocol DetailInteractorInput {
    func loadInformation()
}

class DetailInteractor {
    
    // MARK: - Interactor output
    
    weak var output: DetailInteractorOutput?
    
    // MARK: - Private properties
    
    private let hero: SuperHero
    private let dataManager: DataManagerInput
    
    init(hero: SuperHero, dataManager: DataManagerInput) {
        self.hero = hero
        self.dataManager = dataManager
    }
}

// MARK: - DetailInteractorInput

extension DetailInteractor: DetailInteractorInput {

    func loadInformation() {
        self.dataManager.fetchSuperHero(id: "\(self.hero.id)")
    }
}

// MARK: - DataManagerOutput

extension DetailInteractor: DataManagerOutput {

    func fetchSuperHeroesDidFinish(result: SuperHeroResult) {
        switch result {
        case .success(let hero):
            guard let hero = hero.first else {
                self.output?.showError(text: "Hero doesn't exists")
                return
            }
            self.output?.showSuperHero(with: hero)
        case .error(let error):
            self.output?.showError(text: error.text)
        }
    }
}
