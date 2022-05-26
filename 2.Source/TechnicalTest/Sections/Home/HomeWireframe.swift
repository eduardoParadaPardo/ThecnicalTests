//
//  HomeWireframe.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

protocol HomeWireframeInput {
    func showHome(inNavigation viewController: UINavigationController, list: [SuperHero])
    func showDetail(hero: SuperHero)
}

class HomeWireframe {
    
    // MARK: - Private attributes
    
    private var navigationController: UINavigationController?
    
    // MARK: - Private methods
    
    private func showHome(list: [SuperHero]) -> HomeVC? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.home, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewController.home) as? HomeVC else { return nil }
        let interactor = HomeInteractor(list: list)
        let presenter = HomePresenter(
            interactor: interactor,
            wireframe: self
        )
        interactor.output = presenter
        presenter.output = viewController
        viewController.presenter = presenter
        return viewController
    }
    
    private func showDetail(hero: SuperHero) -> DetailVC? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.detail, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewController.detail) as? DetailVC else { return nil }
        let servicesManager = ServicesManager()
        let storageManager = StorageManager()
        let dataManager = DataManager(
            servicesManager: servicesManager,
            storageManager: storageManager
        )
        let interactor = DetailInteractor(
            hero: hero,
            dataManager: dataManager
        )
        let presenter = DetailPresenter(
            interactor: interactor,
            wireframe: self
        )
        interactor.output = presenter
        presenter.output = viewController
        viewController.presenter = presenter
        servicesManager.output = dataManager
        dataManager.output = interactor
        return viewController
    }
    
    private func createFade() {
        let transition: CATransition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
    }
}

// MARK: - HomeWireframeInput

extension HomeWireframe: HomeWireframeInput {
    
    func showHome(inNavigation viewController: UINavigationController, list: [SuperHero]) {
        guard let vcHome = self.showHome(list: list) else { return print("Error loading vcHome") }
        self.navigationController = viewController
        self.navigationController?.viewControllers.removeAll()
        self.navigationController?.isNavigationBarHidden = false
        
        self.createFade()
        self.navigationController?.pushViewController(vcHome, animated: false)
    }
    
    func showDetail(hero: SuperHero) {
        guard let vcDetail = self.showDetail(hero: hero) else { return print("Error loading vcDetail") }
        self.navigationController?.show(
            vcDetail,
            sender: self
        )
    }
}
