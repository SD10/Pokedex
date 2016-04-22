//
//  PokemonDetailViewController.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
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
    
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
            retrievePokemonData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Methods
    
    func retrievePokemonData() {
        do {
            try DataService.singleService.downloadPokemonDetails("\(pokemon!.pokedexId)", completionHandler: {
                
            })
        } catch DataServiceError.InvalidURL {
            print("Invalid URL: \(DataServiceError.InvalidURL)")
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    // MARK: - Actions
    @IBAction func onBackPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
