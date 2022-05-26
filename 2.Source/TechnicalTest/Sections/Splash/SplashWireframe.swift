//
//  SplashWireframe.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

protocol SplashWireframeInput {
    func showSplash(inNavigation viewController: UINavigationController)
    func showHome(list: [SuperHero])
}

class SplashWireframe {
    
    // MARK: - Private attributes
    
    private var viewController: UIViewController?
    private var navigationController: UINavigationController?
    
    // MARK: - Private methods
    
    private func showSplash() -> SplashVC? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.splash, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewController.splash) as? SplashVC else { return nil }
        
        let servicesManager = ServicesManager()
        let storageManager = StorageManager()
        let dataManager = DataManager(
            servicesManager: servicesManager,
            storageManager: storageManager
        )
        let interactor = SplashInteractor(dataManager: dataManager)
        let presenter = SplashPresenter(
            wireframe: self,
            interactor: interactor
        )
        
        servicesManager.output = dataManager
        dataManager.output = interactor
        interactor.output = presenter
        viewController.presenter = presenter
        return viewController
    }
}

// MARK: - SplashWireframeInput

extension SplashWireframe: SplashWireframeInput {
    
    func showSplash(inNavigation viewController: UINavigationController) {
        guard let vcSplash = self.showSplash() else { return print("Error loading vcSplash") }        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController = viewController
        self.navigationController?.show(
            vcSplash,
            sender: self
        )
    }
    
    func showHome(list: [SuperHero]) {
        guard let navigationController = self.navigationController else { return print("Navigation controller is nil") }
        
        let homeWireframe = HomeWireframe()
        homeWireframe.showHome(inNavigation: navigationController, list: list)
    }
}
