//
//  Constants.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation

// MARK: - URLs
let URL_BASE = "http://pokeapi.co"
let URL_POKEMON = "/api/v1/pokemon/"

// MARK: - Segues
let SHOW_DETAIL = "showPokemonDetail"

// MARK: - Completion Handlers
typealias DownloadComplete = (Pokemon) -> Void
typealias JSONDictionaryCompletion = [String: AnyObject]? -> Void

