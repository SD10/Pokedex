//
//  Pokemon.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation

class Pokemon {
    
    // MARK: - Properties
    private var _name: String
    private var _pokedexId: Int
    private var _descriptionURI: String?
    private var _description: String?
    private var _type: String?
    private var _defense: String?
    private var _height: String?
    private var _weight: String?
    private var _attack: String?
    private var _nextEvolutionText: String?
    
    // MARK: - Getter Methods
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var descriptionURI: String? {
        return _descriptionURI
    }
    
    var description: String? {
        return _description
    }
    
    var type: String? {
        return _type
    }
    
    var defense: String? {
        return _defense
    }
    
    var height: String? {
        return _height
    }
    
    var weight: String? {
        return _weight
    }
    
    var attack: String? {
        return _attack
    }
    
    var nextEvolutionText: String? {
        return _nextEvolutionText
    }
    
    // MARK: - Initializers
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
    // MARK: - Methods
    
    func configurePokemonFromJSON(dictionary: [String: AnyObject]) -> Pokemon {
        
        if let defense = dictionary["defense"] as? Int {
            self._defense = "\(defense)"
        }
        
        if let height = dictionary["height"] as? String {
            self._height = height
        }
        
        if let weight = dictionary["weight"] as? String {
            self._weight = weight
        }
        
        if let attack = dictionary["attack"] as? Int {
            self._attack = "\(attack)"
        }
        
        // FIXME: Consider making primary and secondary types
        if let typesArray = dictionary["types"] as? [[String: String]] where typesArray.count > 0 {
            if let typeName = typesArray[0]["name"] {
                self._type = typeName.capitalizedString
            }
            
            if typesArray.count > 1{
                for x in 1..<typesArray.count {
                    if let typeName = typesArray[x]["name"] {
                        self._type! += "/\(typeName.capitalizedString)"
                    }
                }
            }
        }
        
        if let descriptionArray = dictionary["descriptions"] as? [[String: String]] where descriptionArray.count > 0 {
            if let url = descriptionArray[0]["resource_uri"] {
                self._descriptionURI = url
            }
        }
        
        return self
    }
    
    func configurePokemonDescription(dictionary: [String: AnyObject]) -> Pokemon {
        if let description = dictionary["description"] as? String {
            self._description = description
        }
        return self
    }
}