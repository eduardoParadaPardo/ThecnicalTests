//
//  HomePresenter.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import Foundation

protocol HomePresenterOutput: AnyObject {
    func showSuperHeroList(with list: [SuperHero])
}

protocol HomePresenterInput {
    func viewDidLoad()
    func userDidTapSuperHero(superHero: SuperHero)
}

class HomePresenter {
    
    // MARK: - Public attributes
    
    weak var output: HomePresenterOutput?
    
    // MARK: - Private properties
    
    let interactor: HomeInteractorInput
    let wireframe: HomeWireframeInput
    
    init(interactor: HomeInteractorInput, wireframe: HomeWireframeInput) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - HomePresenterInput

extension HomePresenter: HomePresenterInput {
    
    func viewDidLoad() {
        self.interactor.loadInformation()
    }    
    
    func userDidTapSuperHero(superHero: SuperHero) {
        self.wireframe.showDetail(hero: superHero)
    }
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {

    func showSuperHeroes(list: [SuperHero]) {
        self.output?.showSuperHeroList(with: list)
    }
}
