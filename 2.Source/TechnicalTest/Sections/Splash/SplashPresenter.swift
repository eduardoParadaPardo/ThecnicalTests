//
//  SplashPresenter.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import Foundation

protocol SplashPresenterOutput: AnyObject {
    func updateLoading(show: Bool)
    func showError(text: String)
}

protocol SplashPresenterInput {
    func viewDidLoad()
}

class SplashPresenter {
    
    // MARK: - Public attributes
    
    weak var output: SplashPresenterOutput?
    
    // MARK: - Private attributes
    
    private let wireframe: SplashWireframeInput
    private let interactor: SplashInteractorInput
    
    init(wireframe: SplashWireframeInput, interactor: SplashInteractorInput) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

// MARK: - SplashPresenterInput

extension SplashPresenter: SplashPresenterInput {
    
    func viewDidLoad() {
        // Do something (load initial configuration, prepare next scene,... )
        self.output?.updateLoading(show: true)
        self.interactor.loadInformation()
    }
}

// MARK: - SplashInteractorOutput

extension SplashPresenter: SplashInteractorOutput {
    
    func showHome(list: [SuperHero]) {
        DispatchQueue.main.async {
            self.output?.updateLoading(show: false)
            self.wireframe.showHome(list: list)
        }
    }
    
    func showError(text: String) {
        DispatchQueue.main.async {
            self.output?.showError(text: text)
            self.output?.updateLoading(show: false)
        }
    }
}
