//
//  ViewController.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    var pokemon = [Pokemon]()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        parsePokemonCSV()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Methods
    
    func parsePokemonCSV() {
        guard let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv") else {
            print("Failed to get path of pokemon.csv")
            return
        }
        
        do {
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
                    self.pokemon.append(pokemon)
                } else {
                    throw ParserError.InvalidCastToInt
                }
            }
            
        } catch ParserError.InvalidKey {
            print("Error retrieving data for the key: \(ParserError.InvalidKey)")
        } catch ParserError.InvalidCastToInt {
            print("Unable to cast the pokemon ID to Int")
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

}

// MARK: - Error Handling

enum ParserError: ErrorType {
    case InvalidKey(String)
    case InvalidCastToInt
}

// MARK: - Extensions

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return pokemon.count > 0 ? 1 : 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as? PokemonCell {
            let pokemonForCell = pokemon[indexPath.row]
            cell.configureCell(pokemonForCell)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
}