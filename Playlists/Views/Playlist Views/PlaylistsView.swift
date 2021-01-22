//
//  PlaylistsView.swift
//  Playlists
//
//  Created by Kaleb Page on 12/27/20.
//

import SwiftUI

struct PlaylistsView: View {
    
    @State var createPlaylistShowing: Bool = false
    var playlists = Playlists()
    
    var body: some View {
        
        //save playlist object to disk
        
        VStack {

            Text("Playlist View")
                
            List(playlists.items) { playlist in
                HStack {
                    
                    PlaylistRow(playlist: playlist)

//                    if let playlistID = playlist.id {
//                        PlaylistRow(playlist: playlists[playlistID+1])
//                    }

                }
            }
            
            .navigationBarTitle("My Playlists", displayMode: .inline)
            .navigationBarItems(trailing:
                                                      
                    Button(action: {
                        
                        createPlaylistShowing = true
                        
                    }) {
                        Image(systemName: "plus")
                            .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    }.sheet(isPresented: $createPlaylistShowing) {
                        PlaylistCreator(isShowing: $createPlaylistShowing)
                    }
            
            )
        }
        
    }
}

struct PlaylistsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsView()
    }
}
