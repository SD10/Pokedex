//
//  PokemonDetailViewController.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evolutionLabel: UILabel!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name.capitalizedString
            mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
            pokedexLabel.text = "\(pokemon.pokedexId)"
            retrievePokemonDetails(pokemon)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Methods
    
    func retrievePokemonDetails(pokemon: Pokemon) {
        DataService.singleService.downloadPokemonDetails(pokemon) { (configuredPokemon: Pokemon) in
            dispatch_async(dispatch_get_main_queue()) {
                self.updateUserInterface(configuredPokemon)
            }
        }
    }
    
    func updateUserInterface(pokemon: Pokemon) {
        if let description = pokemon.description {
            descriptionLabel.text = description
        }
        
        if let type = pokemon.type {
            typeLabel.text = type
        }
        
        if let defense = pokemon.defense {
            defenseLabel.text = defense
        }
        
        if let height = pokemon.height {
            heightLabel.text = height
        }
        
        if let weight = pokemon.weight {
            weightLabel.text = weight
        }
        
        if let attack = pokemon.attack {
            attackLabel.text = attack
        }
    }
    
    
    // MARK: - Actions
    @IBAction func onBackPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
