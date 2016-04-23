//
//  ViewController.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    // MARK: - Properties
    
    var dataProvider: PokemonDataProvider?
    lazy var musicPlayer = MusicPlayer()
    var colorTheme = ColorTheme.PikachuYellow
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var mainHeader: UIView!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup data provider
        dataProvider = PokemonDataProvider(collectionView: collectionView)
        dataProvider?.delegate = self
        
        // Setup collection view
        collectionView.dataSource = dataProvider
        collectionView.delegate = dataProvider
        
        // Setup search bar
        searchBar.delegate = dataProvider
        searchBar.returnKeyType = .Done
        
        // Set theme
        setViewColorTheme(colorTheme)
        
        // Init view
        dataProvider?.displayPokemons()
        musicPlayer.togglePlay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Methods
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func setViewColorTheme(mode: ColorTheme) {
        mainHeader.backgroundColor = mode.colorTheme
    }
    
    func retrieveFilePath(name: String, format: String) throws -> String {
        guard let path = NSBundle.mainBundle().pathForResource(name, ofType: format) else {
            throw FilePathError.UnableRetrievePath("\(name).\(format)")
        }
        return path
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction func toggleMusicPressed(sender: UIButton) {
        musicPlayer.togglePlay()
        sender.alpha = musicPlayer.isPlaying ? 1.0 : 0.2
    }
    
    @IBAction func settingsButtonPressed(sender: AnyObject) {
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SHOW_DETAIL {
            if let destinationViewController = segue.destinationViewController as? PokemonDetailViewController {
                if let sender = sender as? Pokemon {
                    destinationViewController.pokemon = sender
                    destinationViewController.colorTheme = self.colorTheme
                }
            }
        }
    }
}

// MARK: PokemonDataProvider Delegate

extension ViewController: PokemonDataProviderDelegate {
    
    func displayDetailsForPokemon(pokemon: Pokemon) {
        performSegueWithIdentifier(SHOW_DETAIL, sender: pokemon)
    }
    
    func shouldHideSearchField() {
        view.endEditing(true)
    }
    
    func showNoResultsLabel(show: Bool, message: String?) {
        noResultsLabel.hidden = !show
        noResultsLabel.text = message
    }
}

