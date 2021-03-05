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
    var description: String?
    var songs: [Song]?
    var image: Data?
    var theme: Theme
    
    //Test Data
    static var sampleImage = UIImage(named: "AMV1")!
    static var sampleSwiftUIImage = Image("AMV1")
    static var testPlaylist = Playlist(name: "Awesome Mix Vol. 1", songs: [Playlist.testSong], theme: Theme(bgColor: CodableColor(uiColor: UIColor(.white)), acColor: CodableColor(uiColor: UIColor(.black)), name: "Default"))
//    static var testSong = Song(id: "913902137", type: "", attributes: Attributes(albumName: "Boston", artistName: "Boston", artwork: Artwork(height: 1000, width: 1000, url: "https://i.etsystatic.com/26546009/r/il/304b47/2748057468/il_1588xN.2748057468_mqxg.jpg"), name: "More Than a Feeling", url: "https://music.apple.com/us/album/immigrant-song/580708279?i=580708280", durationInMillis: 259000))
    
    static var testSong = Song(id: "", type: "", attributes: Attributes(albumName: "-- --", artistName: "", artwork: Artwork(height: 1000, width: 1000, url: "https://player.listenlive.co/templates/StandardPlayerV4/webroot/img/default-cover-art.png"), name: "--- ---", url: "", durationInMillis: 1000))
    
//        https://images-na.ssl-images-amazon.com/images/I/71nYpz%2B%2BVCL._SL1400_.jpg
}


class PlaylistController: ObservableObject {
    
    
    @Published var items: [Playlist] {
        didSet {
            //every time this array is changed, write the new array to disk
            
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            let archiveURL = documentsDirectory.appendingPathComponent("playlists").appendingPathExtension("plist")

            let propertyListEncoder = PropertyListEncoder()

            let encodedItems = try? propertyListEncoder.encode(items)
            
            try? encodedItems?.write(to: archiveURL, options: .noFileProtection)
        }
    }
    
    //when initialized, decode items from disk into item array
    
    init(){
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let archiveURL = documentsDirectory.appendingPathComponent("playlists").appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        
        if let retrievedData = try? Data(contentsOf: archiveURL) {
            if let decodedItems = try? propertyListDecoder.decode([Playlist].self, from: retrievedData) {
                self.items = decodedItems
            } else {
                self.items = []
            }
        } else {
            self.items = []
        }

    }
    
}
