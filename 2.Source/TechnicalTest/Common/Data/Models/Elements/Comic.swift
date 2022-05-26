//
//  Comics.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 25/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

struct ComicKeys {
    static let available = "available"
    static let items = "items"
}

struct Comic: Codable {
    let available: Int
    let itemList: [Item]
    
    init(json: JSON?) {
        self.available = json?[ComicKeys.available]?.toInt() ?? 0
        self.itemList = Item.parseList(json: json?[ComicKeys.items])
    }
    
    static func parseComicJson(json: JSON?) -> Comic? {
        return Comic(json: json)
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
