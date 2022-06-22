//
//  Series.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 25/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

struct SeriesKeys {
    static let available = "available"
    static let items = "items"
}

struct Serie: Codable {
    let available: Int
    let itemList: [Item]
    
    init(json: JSON?) throws {
        self.available = json?[SeriesKeys.available]?.toInt() ?? 0
        self.itemList = try Item.parseList(json: json?[SeriesKeys.items])
    }
    
    static func parseSeriesJson(json: JSON?) throws -> Serie? {
        return try Serie(json: json)
    }
    
    // MARK: - Codable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decode(Int.self, forKey: .available)
        self.itemList = try container.decode([Item].self, forKey: .itemList)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.available, forKey: .available)
        try container.encode(self.itemList, forKey: .itemList)
    }
}
