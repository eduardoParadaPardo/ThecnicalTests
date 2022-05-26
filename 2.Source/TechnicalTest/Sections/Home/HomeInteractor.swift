//
//  HomePresenter.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import Foundation

protocol HomeInteractorOutput: AnyObject {
    func showSuperHeroes(list: [SuperHero])
}
    
protocol HomeInteractorInput {
    func loadInformation()
}

class HomeInteractor {
    
    // MARK: - Interactor output
    
    weak var output: HomeInteractorOutput?
    
    // MARK: - Private properties
    
    private let list: [SuperHero]
    
    init(list: [SuperHero]) {
        self.list = list
    }
}

// MARK: - HomeInteractorInput

extension HomeInteractor: HomeInteractorInput {

    func loadInformation() {
        self.output?.showSuperHeroes(list: self.list.sorted { $0.name < $1.name })
    }
}
