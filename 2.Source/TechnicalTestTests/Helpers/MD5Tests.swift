//
//  MD5Tests.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 26/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import TechnicalTest

class MD5Tests: QuickSpec {
    
    // MARK: - Tests
    
    override func spec() {
        super.spec()
        
        describe("Comparative that md5 is valid") {
            
            it("check several cases") {
                // Checking
                expect(MD5Helper.MD5(string: "Technicaltests") == "e7eb8e7fda2c5143065e9b42dcd2b1fc").toEventually(equal(true))
                expect(MD5Helper.MD5(string: "0asdf$3dwsfs445") == "03ee02740ec577982e2263340827d900").toEventually(equal(true))
                
                // Compared with: http://www.md5.cz/
            }
        }
    }
}
