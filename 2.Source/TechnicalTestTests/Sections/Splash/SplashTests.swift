//
//  SplashTests.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import TechnicalTest

class SplashTests: QuickSpec {
    
    // MARK: - Attributes
    
    var presenter: SplashPresenter!
    var wireframeMock: SplashWireframeMock!
    var splashVCMock: SplashVCMock!
    var serviceManagerMock: ServicesManagerMock!
    var storageManagerMock: StorageManagerMock!
    
    // MARK: - Tests
    
    override func spec() {
        super.spec()
        
        beforeEach {
            self.splashVCMock = SplashVCMock()
            self.wireframeMock = SplashWireframeMock()
            self.serviceManagerMock = ServicesManagerMock()
            self.storageManagerMock = StorageManagerMock()
            
            let dataManager = DataManager(
                servicesManager: self.serviceManagerMock,
                storageManager: self.storageManagerMock
            )
            let interactor = SplashInteractor(
                dataManager: dataManager
            )
            
            self.presenter = SplashPresenter(
                wireframe: self.wireframeMock,
                interactor:interactor
            )
            
            self.presenter.output = self.splashVCMock
            interactor.output = self.presenter
            self.serviceManagerMock.output = dataManager
            dataManager.output = interactor
        }
        
        afterEach {
            self.presenter = nil
            self.wireframeMock = nil
            self.splashVCMock = nil
            self.serviceManagerMock = nil
            self.storageManagerMock = nil
        }
        
        // MARK: - Tests
        
        describe("when view did load section") {
            
            context("storage list is empty") {
                beforeEach {
                    self.storageManagerMock.getHeroList = []
                }
                
                context("request to recover hero list is successfuly") {
                    
                    beforeEach {
                        guard let jsonDic = JSONRecover().getJson(keyJson: "HeroList") else { return print("JSON doesn't found") }
                        self.serviceManagerMock.result = ServiceResult.success(jsonDic)
                    }
                    
                    it("navigate to home section") {
                        // Launch behaibour
                        self.presenter.viewDidLoad()
                        
                        // Checking
                        expect(self.splashVCMock.spyUpdateLoadingCalled).toEventually(equal(true))
                        expect(self.serviceManagerMock.spyFetchSuperHeroesCalled).toEventually(equal(true))
                        expect(self.storageManagerMock.spyGetSuperHeroesCalled).toEventually(equal(true))
                        expect(self.storageManagerMock.spyAddSuperHeroesCalled).toEventually(equal(true))
                        expect(self.splashVCMock.spyShow).toEventually(equal(false))
                        expect(self.wireframeMock.spyShowHomeCalled).toEventually(equal(true))
                        expect(self.wireframeMock.spyHeroList.count == 20).toEventually(equal(true))
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
                        expect(self.splashVCMock.spyUpdateLoadingCalled).toEventually(equal(true))
                        expect(self.serviceManagerMock.spyFetchSuperHeroesCalled).toEventually(equal(true))
                        expect(self.storageManagerMock.spyGetSuperHeroesCalled).toEventually(equal(true))
                        expect(self.storageManagerMock.spyAddSuperHeroesCalled).toEventually(equal(false))
                        expect(self.splashVCMock.spyShow).toEventually(equal(false))
                        expect(self.wireframeMock.spyShowHomeCalled).toEventually(equal(false))
                        expect(self.splashVCMock.spyShowErrorCalled).toEventually(equal(true))
                        expect(self.splashVCMock.spyText == "We can't recover the data").toEventually(equal(true))
                    }
                }
            }            
            
            context("storage have items") {
                beforeEach {
                    guard let jsonDic = JSONRecover().getJson(keyJson: "HeroList") else { return print("JSON doesn't found") }
                     let json = JSON(from: jsonDic)
                    self.storageManagerMock.getHeroList = SuperHero.parseList(json: json)
                }
                
                context("recover items to storege and don't call services") {
                    
                    it("navigate to home section") {
                        // Launch behaibour
                        self.presenter.viewDidLoad()
                        
                        // Checking
                        expect(self.splashVCMock.spyUpdateLoadingCalled).toEventually(equal(true))
                        expect(self.serviceManagerMock.spyFetchSuperHeroesCalled).toEventually(equal(false))
                        expect(self.storageManagerMock.spyGetSuperHeroesCalled).toEventually(equal(true))
                        expect(self.storageManagerMock.spyAddSuperHeroesCalled).toEventually(equal(true))
                        expect(self.splashVCMock.spyShow).toEventually(equal(false))
                        expect(self.wireframeMock.spyShowHomeCalled).toEventually(equal(true))
                        expect(self.wireframeMock.spyHeroList.count == 20).toEventually(equal(true))
                    }
                }
            }
        }
    }
}
