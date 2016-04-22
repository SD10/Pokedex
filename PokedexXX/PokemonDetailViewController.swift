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
    var colorTheme: UIColor?
    
    var statsRetrieved = false {
        didSet {
            if let pokemon = pokemon {
                downloadPokemonDescription(pokemon)
            }
        }
    }
    
    // MARK: - IBOutlets
    
    // Static Labels
    @IBOutlet weak var mainHeader: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var staticTypeLabel: UILabel!
    @IBOutlet weak var staticDefenseLabel: UILabel!
    @IBOutlet weak var staticHeightLabel: UILabel!
    @IBOutlet weak var staticPokedexLabel: UILabel!
    @IBOutlet weak var staticWeightLabel: UILabel!
    @IBOutlet weak var staticAttackLabel: UILabel!
    @IBOutlet weak var evolutionView: UIView!
    
    // Data Labels
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
            downloadPokemonStats(pokemon)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Methods
    
    func downloadPokemonStats(pokemon: Pokemon) {
        DataService.singleService.downloadDataFromPokeAPI("\(URL_POKEMON)\(pokemon.pokedexId)", pokemon: pokemon) { (configuredPokemon: Pokemon) in
            dispatch_async(dispatch_get_main_queue()) {
                self.updatePokemonStats(pokemon)
                self.statsRetrieved = true
            }
        }
    }
    
    func downloadPokemonDescription(pokemon: Pokemon) {
        DataService.singleService.downloadDataFromPokeAPI("\(pokemon.descriptionURI!)", pokemon: pokemon) {
            (configuredPokemon: Pokemon) in
            dispatch_async(dispatch_get_main_queue()) {
                self.updatePokemonDescription(pokemon)
            }
        }
    }
    
    func updatePokemonStats(pokemon: Pokemon) {
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
    
    func updatePokemonDescription(pokemon: Pokemon) {
        if let description = pokemon.description {
            descriptionLabel.text = description
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    // MARK: - Actions
    @IBAction func onBackPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
