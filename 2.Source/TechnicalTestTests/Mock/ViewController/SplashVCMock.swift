//
//  SplashVCMock.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 25/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation
import UIKit

@testable import TechnicalTest

class SplashVCMock: UIViewController, SplashPresenterOutput {
        
    //MARK: - Spy
    
    var spyUpdateLoadingCalled = false
    var spyShowErrorCalled = false
    
    var spyText: String!
    var spyShow: Bool!
    
    // MARK: - SplashPresenterOutput
    
    func updateLoading(show: Bool) {
        self.spyUpdateLoadingCalled = true
        self.spyShow = show
    }
    
    func showError(text: String) {
        self.spyShowErrorCalled = true
        self.spyText = text
    }
}
