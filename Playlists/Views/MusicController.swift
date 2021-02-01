//
//  Queue.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/14/21.
//

import Foundation
import SwiftUI
import MediaPlayer
import Combine

class MusicController: ObservableObject {
    
    @Published var items = [Playlist.testSong] {
        didSet {
            //            refreshMusicPlayer()
        }
    }
    
    var newItem: Song? {
        didSet {
            
            var storeIDs: [String] = []
            
            storeIDs.append(newItem!.id)
            items.append(newItem!)
            
            let descriptor: MPMusicPlayerStoreQueueDescriptor = MPMusicPlayerStoreQueueDescriptor(storeIDs: storeIDs)
            musicPlayer.append(descriptor)
            
        }
    }
    
    @Published var musicPlayer = MPMusicPlayerController.applicationQueuePlayer
    
    var currentSong: Song {
        guard items.count > musicPlayer.indexOfNowPlayingItem else {
            return Song(id: "1440868258", type: "songs", attributes: Attributes(albumName: "Blue Album", artistName: "Weezer", artwork: Artwork(height: 1000, width: 1000, url: "https://images-na.ssl-images-amazon.com/images/I/71nYpz%2B%2BVCL._SL1400_.jpg"), name: "Say It Ain't So", url: "", durationInMillis: 259000))
        }
        return items[musicPlayer.indexOfNowPlayingItem]
    }
    
    init() {
        
        if items.count > 0 {
            
            //set up the queue
            play()
        }
        
    }
    
    func play() {
        refreshMusicPlayer()
        musicPlayer.stop()
        musicPlayer.prepareToPlay()
        musicPlayer.play()
    }
    
    func refreshMusicPlayer() {
        
        
        var storeIDs: [String] = []
        
        for item in items {
            storeIDs.append(item.id)
        }
        
        
        musicPlayer.setQueue(with: storeIDs)
        //        musicPlayer.append(descriptor)
        
    }
}


