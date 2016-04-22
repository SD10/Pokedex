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
        if let description = dictionary["description"] as? String {
            self._description = description
        }
        
        if let type = dictionary["type"] as? String {
            self._type = type
        }
        
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
        
        print(self._attack)
        print(self._description)
        print(self._weight)
        print(self._defense)
        print(self._height)
        print(self._type)
        
        return self
    }
}