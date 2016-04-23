//
//  PokemonDataProvider.swift
//  PokedexXX
//
//  Created by Martin Wildfeuer on 23.04.16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation
import UIKit

/// This delegate communicates changes
/// back to the view controller that
protocol PokemonDataProviderDelegate {
    func displayDetailsForPokemon(pokemon: Pokemon)
    func shouldHideSearchField()
    func showNoResultsLabel(show: Bool, message: String?)
}

class PokemonDataProvider: NSObject {
    
    // MARK: Private
    
    private lazy var pokemon = [Pokemon]()
    private lazy var filteredPokemon = [Pokemon]()
    private var inSearchMode = false
    private weak var collectionView: UICollectionView?
    
    // MARK: Public
    
    var delegate: PokemonDataProviderDelegate?
    
    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
    }
}

// MARK: Fetching Data

extension PokemonDataProvider {
    
    func displayPokemons() {
        do {
            guard let pokemon = try? PokemonDataParser.parsePokemonCSV() else {
                return
            }
            
            self.pokemon.removeAll()
            self.pokemon = pokemon
            collectionView?.reloadData()
        }
    }
}

// MARK: Collection View Data Source

extension PokemonDataProvider: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return pokemon.count > 0 ? 1 : 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredPokemon.count : pokemon.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as? PokemonCell {
            
            let pokemonForCell = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
            cell.configureCell(pokemonForCell)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedPokemon = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        delegate?.displayDetailsForPokemon(selectedPokemon)
        //performSegueWithIdentifier(SHOW_DETAIL, sender: selectedPokemon)
    }
}

// MARK: UICollectionView Delegate

extension PokemonDataProvider: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
}

// MARK: SearchBar Delegate

extension PokemonDataProvider: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            inSearchMode = false
            collectionView?.reloadData()
            delegate?.shouldHideSearchField()
            delegate?.showNoResultsLabel(false, message: nil)
            //view.endEditing(true)
            //noResultsLabel.hidden = true
        } else {
            inSearchMode = true
            let lowerString = searchText.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.containsString(lowerString)})
            let noResultsLabelHidden = !(filteredPokemon.count > 0)
            let noResultsLabelText = "No results found for '\(searchText)'"
            delegate?.showNoResultsLabel(noResultsLabelHidden, message: noResultsLabelText)
            collectionView?.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        delegate?.shouldHideSearchField()
    }
}