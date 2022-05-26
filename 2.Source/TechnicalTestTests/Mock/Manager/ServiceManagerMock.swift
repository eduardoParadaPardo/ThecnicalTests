//
//  ServiceManagerMock.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 25/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation
import UIKit

@testable import TechnicalTest

class ServicesManagerMock: ServicesManagerInput {
    
    //MARK: - Spy

    var spyFetchSuperHeroesCalled = false
    var spyFetchSuperHeroCalled = false
    var spyDownloadImagCalled = false
    
    var spyId: String!
    var spyUrl: String!
    
    // MARK: - Public properties
    
    var output: ServicesManagerOutput?
    var result: ServiceResult<Any>!
    
    // MARK: - ServicesManagerInput
    
    func fetchSuperHeroes() {
        self.spyFetchSuperHeroesCalled = true
        self.output?.fetchSuperHeroDidFinsh(result: self.result)
    }
    
    func fetchSuperHero(id: String) {
        self.spyFetchSuperHeroCalled = true
        self.spyId = id
        self.output?.fetchSuperHeroDidFinsh(result: self.result)
    }
    
    func downloadImag(url: String, completion: @escaping (UIImage?) -> Void) {
        self.spyDownloadImagCalled = true
        self.spyUrl = url
    }
}
