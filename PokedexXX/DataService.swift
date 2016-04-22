//
//  PokeService.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation
import Alamofire

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
    
    func downloadPokemonDetails(pokedexId: String, completionHandler: DownloadComplete) throws {
        let urlString = "\(baseURL)\(pokemonURL)\(pokedexId)"
        
        guard let url = NSURL(string: urlString) else {
            throw DataServiceError.InvalidURL("urlString")
        }
        
        Alamofire.request(.GET, url).responseJSON { (response: Response<AnyObject, NSError>) in
            let result = response.result
            print(result)
        }
    }
}

// MARK: - Error Handling

enum DataServiceError: ErrorType {
    case InvalidURL(String)
}