//
//  TTError.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 25/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

class TTError: Error {
    
    enum ErrorType {
        case generalError
        case urlNil
        case error(error: Error)
        case dataNil
        case invalidParams
        case dbContainerError
    }
    
    var type: ErrorType
    var text: String
    
    init(type: ErrorType) {
        print("Error: \(type)") // Use a logManager to control logs
        self.type = type
        switch type {
        case .generalError:
            self.text = "General error"
        case .urlNil:
            self.text = "Invalid url"
        case .error(let error):
            self.text = error.localizedDescription
        case .dataNil:
            self.text = "We can't recover the data"
        case .invalidParams:
            self.text = "Invalid request params"
        case .dbContainerError:
            self.text = "Problem when storage data"
        }
    }
}
