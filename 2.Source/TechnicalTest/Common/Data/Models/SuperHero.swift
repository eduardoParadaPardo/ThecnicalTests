//
//  SuperHero.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 23/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation

struct SuperHeroKeys {
    static let id = "id"
    static let name = "name"
    static let description = "description"
    static let thumbnailPath = "thumbnail.path"
    static let thumbnailExt = "thumbnail.extension"
    static let comics = "comics"
    static let series = "series"
    static let stories = "stories"
}

struct SuperHero {
    
    let id: Int
    let name: String
    let description: String
    let image: String
    var comics: Comic?
    var serie: Serie?
    var story: Story?
    
    init(json: JSON?) throws {
        self.id = json?[SuperHeroKeys.id]?.toInt() ?? 0
        self.name = json?[SuperHeroKeys.name]?.toString() ?? ""
        self.description = json?[SuperHeroKeys.description]?.toString() ?? ""
        self.image = (json?[SuperHeroKeys.thumbnailPath]?.toString() ?? "") + "." +  (json?[SuperHeroKeys.thumbnailExt]?.toString() ?? "")
        self.comics = try Comic.parseComicJson(json: json?[SuperHeroKeys.comics])
        self.serie = try Serie.parseSeriesJson(json: json?[SuperHeroKeys.series])
        self.story = try Story.parseStoriesJson(json: json?[SuperHeroKeys.stories])
    }
    
    init(hero: Hero) throws {
        self.id = Int(hero.id ?? "0") ?? 0
        self.name = hero.name ?? ""
        self.description = hero.description
        self.image = hero.imag ?? ""
        do {
            self.comics = try JSONDecoder().decode(Comic.self, from: hero.comics ?? Data())
            self.serie = try JSONDecoder().decode(Serie.self, from: hero.series ?? Data())
            self.story = try JSONDecoder().decode(Story.self, from: hero.stories ?? Data())
        } catch {
            print("Error decoding")
            self.comics = nil
            self.serie = nil
            self.story = nil
        }
    }
    
    // MARK: - Parser
    
    // MARK: - CORE DATA
    
    static func parseList(heroList: [Hero]) throws -> [SuperHero] {
        return try heroList.compactMap(parseHeroes)
    }
    
    static func parseHeroes(value: Any) throws -> SuperHero? {
        guard let hero = value as? Hero else {
            print("Eror parsing")
            throw TTError(type: .dataNil)
        }
        return try SuperHero(hero: hero)
    }
    
    // MARK: - SERVICES
    
    static func parseList(json: JSON?) throws -> [SuperHero] {
        guard let json = json?["data.results"]?.toArray() else {
            print("No result parsing")
            throw TTError(type: .dataNil)
        }
        return try json.compactMap(parseHeroJson)
    }
    
    static func parseHeroJson(value: Any) throws -> SuperHero? {
        let json = JSON(from: value)
        return try SuperHero(json: json)
    }
}
