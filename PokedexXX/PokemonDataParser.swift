//
//  PokemonDataParser.swift
//  PokedexXX
//
//  Created by Martin Wildfeuer on 23.04.16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation

struct PokemonDataParser {
    
    static func parsePokemonCSV() throws -> [Pokemon] {
        var pokemons = [Pokemon]()
        do {
            let path = try retrieveFilePath("pokemon", format: "csv")
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            
            
            for row in rows {
                guard let pokeId = row["id"] else {
                    throw ParserError.InvalidKey("id")
                }
                guard let name = row["identifier"] else {
                    throw ParserError.InvalidKey("identifier")
                }
                
                if let identifier = Int(pokeId) {
                    let pokemon = Pokemon(name: name, pokedexId: identifier)
                    pokemons.append(pokemon)
                } else {
                    throw ParserError.InvalidCastToInt
                }
            }
            
            return pokemons
            
        } catch FilePathError.UnableRetrievePath {
            print("Error retrieving file path for \(FilePathError.UnableRetrievePath)")
            return pokemons
        } catch ParserError.InvalidKey {
            print("Error retrieving data for the key: \(ParserError.InvalidKey)")
            return pokemons
        } catch ParserError.InvalidCastToInt {
            print("Unable to cast the pokemon ID to Int")
            return pokemons
        } catch let error as NSError {
            print(error.debugDescription)
            return pokemons
        }
    }
    
    static func retrieveFilePath(name: String, format: String) throws -> String {
        guard let path = NSBundle.mainBundle().pathForResource(name, ofType: format) else {
            throw FilePathError.UnableRetrievePath("\(name).\(format)")
        }
        return path
    }
}

// MARK: - Error Handling

enum ParserError: ErrorType {
    case InvalidKey(String)
    case InvalidCastToInt
}

enum FilePathError: ErrorType {
    case UnableRetrievePath(String)
    case UnableCreateURL
}