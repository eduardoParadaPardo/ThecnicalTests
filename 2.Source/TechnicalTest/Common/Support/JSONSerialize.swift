//
//  JSONSerialize.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import Foundation

class JSONSerialize {
    
    class func parser(string: String) -> [String: AnyObject] {
        guard let data = string.data(using: .utf8) else {
            print("data is nil parsing json")
            return [:]
        }
        
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
                return jsonArray
            } else {
                print("Json bad formet")
                return [:]
            }
        } catch let error as NSError {
            print("When set serialize json: \(error)")
            return [:]
        }
    }
}
