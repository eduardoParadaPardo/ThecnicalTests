//
//  StorageManager.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 23/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation
import CoreData

enum CodingKeys: String, CodingKey {
    case available
    case itemList
    case name
    case type
}

protocol StorageManagerInput {
    func getSuperHeroes() throws -> [SuperHero]
    func addSuperHeroes(heroList: [SuperHero]) throws
}

class StorageManager {
    
    // MARK: - Private properties
    
    private let container: NSPersistentContainer?
    
    init() {
        self.container = NSPersistentContainer(name: "Heroes")
        self.setupDatabase()
    }
    
    // MARK: - Private methods
        
    private func setupDatabase() {
        guard let container = self.container else {
            print("Container Error")
            return
        }

        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading store \(desc) — \(error)")
                return
            }
        }
    }
    
    private func fetchHeroList() throws -> [SuperHero] {
        let fetchRequest: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        guard let container = self.container else {
            print("Container Error")
            throw TTError(type: .dbContainerError)
        }
        
        let result = try container.viewContext.fetch(fetchRequest)
        return try SuperHero.parseList(heroList: result)
    }
    
    private func controlAddHero(superHero: SuperHero) throws {
        let founded = try self.fetchHeroList().filter { hero in
            return hero.id == superHero.id
        }
        if founded.count == 0 {
            try self.createHero(superHero: superHero)
        }
    }
    
    private func createHero(superHero: SuperHero) throws {
        guard let container = self.container else {
            print("Container Error")
            throw TTError(type: .dbContainerError)
        }
        
        container.performBackgroundTask { (context) in
            let hero = Hero(context: context)
            hero.id = String(superHero.id)
            hero.name = superHero.name
            hero.descript = superHero.description
            hero.imag = superHero.image            
            
            do {
                hero.comics = try JSONEncoder().encode(superHero.comics)
                hero.series = try JSONEncoder().encode(superHero.serie)
                hero.stories = try JSONEncoder().encode(superHero.story)
                try context.save()
                print("Hero \(String(describing: hero.name)) saved")
                context.reset()
                
            } catch {
                print("Saving hero error — \(error)")
            }
        }
    }
}

// MARK: - StorageManagerInput

extension StorageManager: StorageManagerInput {
    
    func getSuperHeroes() throws -> [SuperHero] {
        return try self.fetchHeroList()
    }
    
    func addSuperHeroes(heroList: [SuperHero]) throws {
        _ = try heroList.map { superHero in
            try self.controlAddHero(superHero: superHero)
        }
    }
}
