//
//  PokeService.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation

class DataService {
    static let singleService = DataService()
    
    private var _baseURL = "http://pokeapi.co"
    private var _pokemonURL = "/api/v1/pokemon/"
    
    var baseURL: String {
        return _baseURL
    }
    
    var pokemonURL: String {
        return _pokemonURL
    }
    
    //FIXME: Refactor using relative to URL
    func downloadPokemonDetails(pokemon: Pokemon, completionHandler: DownloadComplete) {
        let urlString = "\(baseURL)\(pokemonURL)\(pokemon.pokedexId)"
        
        guard let url = NSURL(string: urlString) else {
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
    
    func downloadPokemonDescription(pokemon: Pokemon, completionHandler: DownloadComplete) {
        //FIXME: Don't force unwrap here
        let urlString = "\(baseURL)\(pokemon.descriptionURI!)"
        
        guard let url = NSURL(string: urlString) else {
            return
        }
        
        let networkOperation = NetworkOperation(url: url)
        
        networkOperation.downloadJSONFromURL { (jsonDictionary: [String : AnyObject]?) in
            if let jsonDictionary = jsonDictionary {
                let configuredPokemon = pokemon.configurePokemonDescription(jsonDictionary)
                print("I was configured: \(configuredPokemon)")
                completionHandler(configuredPokemon)
            }
        }
        
    }
}