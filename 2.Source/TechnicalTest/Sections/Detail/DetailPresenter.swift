//
//  DetailPresenter.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 24/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

protocol DetailPresenterOutput: AnyObject {
    func updateLoading(show: Bool)
    func showError(text: String)
    func showSuperHero(with hero: SuperHero)
}

protocol DetailPresenterInput {
    func viewDidLoad()
}

class DetailPresenter {
    
    // MARK: - Public attributes
    
    weak var output: DetailPresenterOutput?
    
    // MARK: - Private properties
    
    let interactor: DetailInteractorInput
    let wireframe: HomeWireframeInput
    
    init(interactor: DetailInteractorInput, wireframe: HomeWireframeInput) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - DetailPresenterInput

extension DetailPresenter: DetailPresenterInput {
    
    func viewDidLoad() {
        self.output?.updateLoading(show: true)
        self.interactor.loadInformation()
    }
}

// MARK: - DetailInteractorOutput

extension DetailPresenter: DetailInteractorOutput {
    
    func showError(text: String) {
        DispatchQueue.main.async {
            self.output?.updateLoading(show: false)
            self.output?.showError(text: text)
        }
    }

    func showSuperHero(with hero: SuperHero) {
        DispatchQueue.main.async {
            self.output?.updateLoading(show: false)
            self.output?.showSuperHero(with: hero)
        }
    }
}
