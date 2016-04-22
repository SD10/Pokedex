//
//  PokeService.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation

struct DataService {
    static let singleService = DataService()
    
    private var _baseURL = "http://pokeapi.co"
    private var _pokemonURL = "/api/v1/pokemon/"
    
    var baseURL: String {
        return _baseURL
    }
    
    var pokemonURL: String {
        return _pokemonURL
    }
    
    func downloadDataFromPokeAPI(query: String, pokemon: Pokemon, completionHandler: DownloadComplete) {
        
        guard let url = NSURL(string: "\(baseURL)\(query)") else {
            return
        }
        
        print("THIS IS THE URL: \(url)")
        
        let networkOperation = NetworkOperation(url: url)
        
        networkOperation.downloadJSONFromURL { (jsonDictionary: [String : AnyObject]?) in
            if let jsonDictionary = jsonDictionary {
                let configuredPokemon = pokemon.configurePokemonFromJSON(jsonDictionary)
                completionHandler(configuredPokemon)
            }
        }
    }
}