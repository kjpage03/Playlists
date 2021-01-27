//
//  PlaylistView.swift
//  Playlists
//
//  Created by Kaleb Page on 12/20/20.
//

import SwiftUI

struct PlaylistView: View {
    
    var playlist: Playlist
    @EnvironmentObject var playlistController: PlaylistController
    @State var editShowing = false
    
    var body: some View {
                
//            if let description = playlist.description {
//                Text(description)
//            }
            
            VStack {
                
                
                HStack() {
                    PlaylistControls()
                        .padding()
                    Spacer()
                }
                
                if let songs = playlist.songs {
                    List(songs) { song in
                        SongRow(song: song)
                    }

                    .navigationBarTitle(playlist.name, displayMode: .large)
                    .navigationBarItems(trailing: Button(action: {
                        print("Edit icon pressed...")
                        editShowing = true
                    }) {
                        Image(systemName: "pencil").imageScale(.large)
                    })
                    .sheet(isPresented: $editShowing, content: {
                        PlaylistEditor(playlist: playlist, editShowing: $editShowing)
                    })

                } else {
                
                VStack(spacing: 8) {
                    
                    NavigationLink(destination: SearchView(songs: nil, backButtonHidden: true)) {
                        Image(systemName: "plus")
                            .frame(width: 50, height: 50, alignment: .center)
                            .scaleEffect(CGSize(width: 3, height: 3))
                            .foregroundColor(.blue)
                    }

                    Text("Add Songs")
                        .fontWeight(.light)
                }
                .navigationBarTitle(playlist.name, displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    print("Edit icon pressed...")
                    editShowing = true
                }) {
                    Image(systemName: "pencil").imageScale(.large)
                })
                .sheet(isPresented: $editShowing, content: {
                    PlaylistEditor(playlist: playlist, editShowing: $editShowing)
                })
                
                }
                
        }
        
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(playlist: Playlist.testPlaylist)
    }
}
