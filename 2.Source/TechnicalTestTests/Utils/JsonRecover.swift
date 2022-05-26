//
//  JsonRecover.swift
//  TechnicalTestTests
//
//  Created by eduardo parada pardo on 25/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

class JSONRecover {
    
    func getJson(keyJson: String) -> Any? {
        let bundle = Bundle(for: type(of: self))
        
        if let path = bundle.path(forResource: keyJson, ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    return jsonResult
                } catch {
                    return nil
                }
            } catch {
                return nil
            }
        }
        return nil
    }
}
