//
//  PokemonDetailViewController.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(pokemon?.name)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
