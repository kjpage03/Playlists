//
//  PlaylistView.swift
//  Playlists
//
//  Created by Kaleb Page on 12/20/20.
//

import SwiftUI

struct PlaylistView: View {
    
    var playlist: Playlist
    
    var body: some View {
        
        Text("Future Playlist View")
        /*
        VStack {
            List(playlist.songs!) { song in
                SongRow(song: song)
            }
            .navigationBarTitle(playlist.name, displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                print("User icon pressed...")
            }) {
                Image(systemName: "pencil").imageScale(.large)
            })
        }
         
        */
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(playlist: Playlist.testPlaylist)
    }
}
