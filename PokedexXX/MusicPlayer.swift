//
//  MusicPlayer.swift
//  PokedexXX
//
//  Created by Martin Wildfeuer on 23.04.16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation
import AVFoundation

struct MusicPlayer {
    
    // MARK: Private
    
    private var musicPlayer = AVAudioPlayer()
    
    mutating private func setUp() {
        do {
            guard let url = NSURL(string: try NSBundle.retrieveFilePath("music", format: "mp3")) else {
                throw FilePathError.UnableCreateURL
            }
            musicPlayer = try AVAudioPlayer(contentsOfURL: url)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
        } catch FilePathError.UnableCreateURL {
            print("Could not create URL for file path")
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    // MARK: Public
    
    init() { setUp() }
    
    var isPlaying: Bool {
        return musicPlayer.playing
    }
    
    mutating func togglePlay() {
        if musicPlayer.playing {
            musicPlayer.stop()
        } else {
            musicPlayer.play()
        }
    }
}