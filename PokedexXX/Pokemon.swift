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
    
    private var _nextEvolutionId: String?
    private var _nextEvolutionText: String?
    private var _nextEvolutionLvl: String?
    
    // MARK: - Getters
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId!
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl!
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = "No Evolutions"
        }
        return _nextEvolutionText!
    }
    
    
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
        
        if let evolutions = dictionary["evolutions"] as? [[String: AnyObject]] where evolutions.count > 0 {
            if let to = evolutions[0]["to"] as? String {
                // Can't support mega pokemon right now but
                // API still has mega data
                if to.rangeOfString("mega") == nil {
                    if let uri = evolutions[0]["resource_uri"] as? String {
                        let newString = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                        let pokeNumber = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                        self._nextEvolutionId = pokeNumber
                        self._nextEvolutionText = to
                        
                        if let level = evolutions[0]["level"] as? Int {
                            self._nextEvolutionLvl = "\(level)"
                        }
                        
                        print(self.nextEvolutionText)
                        print(self.nextEvolutionId)
                        print(self._nextEvolutionLvl)
                    }
                }
            }
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