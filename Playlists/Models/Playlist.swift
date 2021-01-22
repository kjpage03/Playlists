//
//  Playlist.swift
//  Playlists
//
//  Created by Kaleb Page on 12/20/20.
//

import Foundation
import UIKit
import SwiftUI

struct Playlist: Identifiable, Codable {

    var id = UUID()
    var name: String
    var songs: [Song]?
    var image: Data?
    
    //Test Data
    static var sampleImage = UIImage(named: "AMV1")!
    static var sampleSwiftUIImage = Image("AMV1")
    static var testPlaylist = Playlist(name: "Awesome Mix Vol. 1", songs: [Playlist.testSong])
    static var testSong = Song(id: "", type: "", attributes: Attributes(albumName: "Blue Album", artistName: "Weezer", artwork: Artwork(height: 1000, width: 1000, url: "https://images-na.ssl-images-amazon.com/images/I/71nYpz%2B%2BVCL._SL1400_.jpg"), name: "Say It Ain't So", url: "https://music.apple.com/us/album/immigrant-song/580708279?i=580708280", durationInMillis: 259000))

}


class Playlists {
    
    var items: [Playlist] {

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let archiveURL = documentsDirectory.appendingPathComponent("playlists").appendingPathExtension("plist")

        let propertyListDecoder = PropertyListDecoder()

        //pull playlist data from disk

        if let retrievedPlaylists = try? Data(contentsOf: archiveURL), let decodedPlaylists = try? propertyListDecoder.decode([Playlist].self, from: retrievedPlaylists) {
            return decodedPlaylists
        } else {
            return [Playlist.testPlaylist]
        }
        
        
    }

}
