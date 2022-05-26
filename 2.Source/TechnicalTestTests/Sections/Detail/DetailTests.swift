//
//  DetailTests.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 26/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import TechnicalTest

class DetailTests: QuickSpec {
    
    // MARK: - Attributes
    var presenter: DetailPresenter!
    var viewMock: DetailVCMock!
    var wireframeMock: HomeWireframeMock!
    var serviceManagerMock: ServicesManagerMock!
    var storageManagerMock: StorageManagerMock!
    
    // MARK: - Tests
    
    override func spec() {
        super.spec()
        
        beforeEach {
            self.viewMock = DetailVCMock()
            self.wireframeMock = HomeWireframeMock()
        
            guard let jsonDic = JSONRecover().getJson(keyJson: "Hero") else { return print("JSON doesn't found") }
            let json = JSON(from: jsonDic)
            let hero = SuperHero.parseList(json: json).first!
            
            self.serviceManagerMock = ServicesManagerMock()
            self.storageManagerMock = StorageManagerMock()
            
            let dataManager = DataManager(
                servicesManager: self.serviceManagerMock,
                storageManager: self.storageManagerMock
            )
            let interactor = DetailInteractor(
                hero: hero,
                dataManager: dataManager
            )
            
            self.presenter = DetailPresenter(
                interactor: interactor,
                wireframe: self.wireframeMock
            )
            
            interactor.output = self.presenter
            self.presenter.output = self.viewMock
            self.serviceManagerMock.output = dataManager
            dataManager.output = interactor
        }
        
        afterEach {
            self.presenter = nil
            self.viewMock = nil
            self.wireframeMock = nil
            self.serviceManagerMock = nil
            self.storageManagerMock = nil
        }
        
        describe("when view did load section") {
            
            context("request to recover hero list is successfuly") {
                
                beforeEach {
                    guard let jsonDic = JSONRecover().getJson(keyJson: "Hero") else { return print("JSON doesn't found") }
                    self.serviceManagerMock.result = ServiceResult.success(jsonDic as Any)
                }
                
                it("navigate to home section") {
                    // Value
                    guard let jsonDic = JSONRecover().getJson(keyJson: "Hero") else { return print("JSON doesn't found") }
                    let json = JSON(from: jsonDic)
                    let hero = SuperHero.parseList(json: json).first!
                    
                    // Launch behaibour
                    self.presenter.viewDidLoad()
                    
                    // Checking
                    expect(self.viewMock.spyUpdateLoadingCalled).toEventually(equal(true))
                    expect(self.serviceManagerMock.spyFetchSuperHeroCalled).toEventually(equal(true))
                    
                    expect(self.viewMock.spyShow).toEventually(equal(false))
                    expect(self.viewMock.spyShowSuperHeroCalled).toEventually(equal(true))
                    expect(self.viewMock.spyHero.id == hero.id).toEventually(equal(true))
                }
            }
            
            context("request fail to recover hero list") {
                
                beforeEach {
                    self.serviceManagerMock.result = ServiceResult.error(error: TTError(type: .dataNil))
                }
                
                it("show error about data is empty") {
                    // Launch behaibour
                    self.presenter.viewDidLoad()
                    
                    // Checking
                }
            }
        }
    }
}

