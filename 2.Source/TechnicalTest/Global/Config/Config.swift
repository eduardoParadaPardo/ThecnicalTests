//
//  Config.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import Foundation

// If we had different environments, here we would control the environments through the xcconfig
 
class Config {
    static let baseUrl = InfoDictionary("BASEURL")
    static let apikey = InfoDictionary("APIKEY")
    static let secretkey = InfoDictionary("SECRETKEY")
}

// swiftlint: disable identifier_name
public func InfoDictionary(_ key: String) -> String {
    guard let constant = Bundle.main.infoDictionary?[key] as? String else {
        print("Constant is nil")
        return "Constant is nil"
    }
    return constant.replacingOccurrences(of: "\\", with: "").replacingOccurrences(of: "\"", with: "")
}
