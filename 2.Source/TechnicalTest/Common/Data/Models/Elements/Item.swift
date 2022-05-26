//
//  Items.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 25/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

struct ItemKeys {
    static let name = "name"
    static let type = "type"
}

enum ItemType: String {
    case cover
    case interiorStory
}

struct Item: Codable {
    let name: String
    let type: ItemType?
        
    init(json: JSON?) {
        self.name = json?[ItemKeys.name]?.toString() ?? ""
        if let type = json?[ItemKeys.type] {
            self.type = ItemType(rawValue: type.toString() ?? "cover")
        } else {
            self.type = nil
        }
    }
    
    static func parseList(json: JSON?) -> [Item] {
        guard let json = json?.toArray() else {
            print("No items result")
            return []
        }
        return json.compactMap(parsItemJson)
    }
    
    static func parsItemJson(value: Any) -> Item? {
        let json = JSON(from: value)
        return Item(json: json)
    }
    
    // MARK: - Codable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        
        do {
            self.type = ItemType(rawValue: try container.decode(String.self, forKey: .type))
        } catch {
            self.type = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.type?.rawValue, forKey: .type)
    }
}
