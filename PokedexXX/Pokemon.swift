//
//  Pokemon.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation

final class Pokemon {
    
    // MARK: - Properties
    
    private(set) var name: String
    private(set) var pokedexId: Int
    private(set) var descriptionURI: String?
    private(set) var description: String?
    private(set) var type: String?
    private(set) var defense: String?
    private(set) var height: String?
    private(set) var weight: String?
    private(set) var attack: String?
    private(set) var nextEvolutionText: String?
    private(set) var nextEvolutionLvl: String?
    private(set) var nextEvolutionId: String?
    
    
    // MARK: - Initializers
    
    init(name: String, pokedexId: Int) {
        self.name = name
        self.pokedexId = pokedexId
    }
    
    // MARK: - Methods
    
    func configurePokemonFromJSON(dictionary: [String: AnyObject]) -> Pokemon {
        
        if let description = dictionary["description"] as? String {
            self.description = description
            return self
        }
        
        if let defense = dictionary["defense"] as? Int {
            self.defense = "\(defense)"
        }
        
        if let height = dictionary["height"] as? String {
            self.height = height
        }
        
        if let weight = dictionary["weight"] as? String {
            self.weight = weight
        }
        
        if let attack = dictionary["attack"] as? Int {
            self.attack = "\(attack)"
        }
        
        // FIXME: Consider making primary and secondary types
        if let typesArray = dictionary["types"] as? [[String: String]] where typesArray.count > 0 {
            if let typeName = typesArray[0]["name"] {
                self.type = typeName.capitalizedString
            }
            
            if typesArray.count > 1{
                for x in 1..<typesArray.count {
                    if let typeName = typesArray[x]["name"] {
                        self.type! += "/\(typeName.capitalizedString)"
                    }
                }
            }
        }
        
        if let descriptionArray = dictionary["descriptions"] as? [[String: String]] where descriptionArray.count > 0 {
            if let url = descriptionArray[0]["resource_uri"] {
                self.descriptionURI = url
            }
        }
        
        return self
    }
}