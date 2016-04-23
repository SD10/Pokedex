//
//  ViewController.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController  {
    
    // MARK: - Properties
    
    var dataProvider: PokemonDataProvider?
    lazy var musicPlayer = AVAudioPlayer()
    var colorTheme = ColorTheme.PikachuYellow
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var mainHeader: UIView!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dataProvider = PokemonDataProvider(collectionView: collectionView)
        dataProvider?.delegate = self
        collectionView.dataSource = dataProvider
        collectionView.delegate = dataProvider
        
        searchBar.delegate = dataProvider
        searchBar.returnKeyType = .Done
        setViewColorTheme(colorTheme)
        
        dataProvider?.displayPokemons()
        configureMusicPlayer()
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
    
    func configureMusicPlayer() {
        do {
            guard let url = NSURL(string: try retrieveFilePath("music", format: "mp3")) else {
                throw FilePathError.UnableCreateURL
            }
            musicPlayer = try AVAudioPlayer(contentsOfURL: url)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch FilePathError.UnableCreateURL {
            print("Could not create URL for file path")
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction func toggleMusicPressed(sender: UIButton) {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
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

