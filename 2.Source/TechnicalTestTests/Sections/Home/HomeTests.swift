//
//  HomeTests.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//
import Foundation
import Quick
import Nimble
@testable import TechnicalTest

class ShopTests: QuickSpec {
    
    // MARK: - Attributes
    var presenter: HomePresenter!
    var viewMock: HomeViewMock!
    var wireframeMock: HomeWireframeMock!
    
    // MARK: - Tests
    
    override func spec() {
        super.spec()
        
        beforeEach {
            self.viewMock = HomeViewMock()
            self.wireframeMock = HomeWireframeMock()
            
            guard let jsonDic = JSONRecover().getJson(keyJson: "HeroList") else { return print("JSON doesn't found") }
             let json = JSON(from: jsonDic)
            
            let interactor = HomeInteractor(list: SuperHero.parseList(json: json))
            
            self.presenter = HomePresenter(
                interactor: interactor,
                wireframe: self.wireframeMock
            )
            
            interactor.output = self.presenter
            self.presenter.output = self.viewMock
        }
        
        afterEach {
            self.presenter = nil
            self.viewMock = nil
            self.wireframeMock = nil
        }
        
        describe("when view did load section") {
            
            context("recover hero list in cache") {                
                    
                it("show items shorted") {
                    // Launch behaibour
                    self.presenter.viewDidLoad()
                    
                    // Checking
                    expect(self.viewMock.spyList.count == 20).toEventually(equal(true))
                    expect(self.viewMock.spyShowSuperHeroListCalled).toEventually(equal(true))
                }
            }
        }
        
        describe("when user did tap a cell") {
                    
            it("navigate to detail section with this hero") {
                // Values
                guard let jsonDic = JSONRecover().getJson(keyJson: "HeroList") else { return print("JSON doesn't found") }
                let json = JSON(from: jsonDic)                
                let heroList = SuperHero.parseList(json: json)
                
                // Launch behaibour
                self.presenter.userDidTapSuperHero(superHero: heroList.first!)
                
                // Checking
                expect(self.wireframeMock.spyShowDetailCalled).toEventually(equal(true))
                expect(self.wireframeMock.spyHero.id == heroList.first!.id).toEventually(equal(true))
            }
        }
    }
}
