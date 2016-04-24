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
    
    private var baseURL = "http://pokeapi.co"
    private var pokemonURL = "/api/v1/pokemon/"
    
    func downloadDataFromPokeAPI(query: String, pokemon: Pokemon, completionHandler: DownloadComplete) {
        
        guard let url = NSURL(string: "\(baseURL)\(query)") else {
            return
        }
        
        let networkOperation = NetworkOperation(url: url)
        
        networkOperation.downloadJSONFromURL { (jsonDictionary: [String : AnyObject]?) in
            if let jsonDictionary = jsonDictionary {
                let configuredPokemon = pokemon.configurePokemonFromJSON(jsonDictionary)
                completionHandler(configuredPokemon)
            }
        }
    }
}