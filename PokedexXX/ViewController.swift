//
//  ViewController.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    var pokemon = [Pokemon]()
    lazy var filteredPokemon = [Pokemon]()
    lazy var musicPlayer = AVAudioPlayer()
    var inSearchMode = false
    var colorTheme = ColorTheme.PikachuYellow
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var mainHeader: UIView!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = .Done
        setViewColorTheme(colorTheme)
        parsePokemonCSV()
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
    
    func parsePokemonCSV() {
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
                    self.pokemon.append(pokemon)
                } else {
                    throw ParserError.InvalidCastToInt
                }
            }
        } catch FilePathError.UnableRetrievePath {
            print("Error retrieving file path for \(FilePathError.UnableRetrievePath)")
        } catch ParserError.InvalidKey {
            print("Error retrieving data for the key: \(ParserError.InvalidKey)")
        } catch ParserError.InvalidCastToInt {
            print("Unable to cast the pokemon ID to Int")
        } catch let error as NSError {
            print(error.debugDescription)
        }
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
    
    func searchFieldEmpty() -> Bool {
        return searchBar.text == nil || searchBar.text == ""
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

// MARK: - Error Handling

enum ParserError: ErrorType {
    case InvalidKey(String)
    case InvalidCastToInt
}

enum FilePathError: ErrorType {
    case UnableRetrievePath(String)
    case UnableCreateURL
}

// MARK: - Extensions

    // CollectionView Delegate

extension ViewController: UICollectionViewDataSource {
    
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
        performSegueWithIdentifier(SHOW_DETAIL, sender: selectedPokemon)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
}

    // SearchBar Delegate

extension ViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchFieldEmpty() {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
            noResultsLabel.hidden = true
        } else {
            inSearchMode = true
            let lowerString = searchText.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.containsString(lowerString)})
            noResultsLabel.hidden = filteredPokemon.count > 0
            noResultsLabel.text = "No results found for '\(lowerString)'"
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

