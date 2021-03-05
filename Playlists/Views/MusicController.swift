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
    
    @Published var items: [Song] = []
    
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
            return Playlist.testSong
        }
        return items[musicPlayer.indexOfNowPlayingItem]
    }
    
    init() {
        
        if items.count > 0 {
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


