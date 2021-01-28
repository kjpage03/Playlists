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
    var defaultImage = UIImage(named: "gray-square")
    
    var body: some View {
        
        VStack {
            
            HStack() {
                Spacer()
                if let image = playlist.image {
                    
                    Image(uiImage: (UIImage(data: image) ?? defaultImage!))
                        .resizable()
                        .frame(width: 115, height: 115)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .offset(x: 0, y: 15)
                }
            }.frame(width: 350, height: 0)
            
            HStack() {
                if let description = playlist.description {
                    VStack {
                        Text(description)
                        PlaylistControls()
                            .padding()
                    }
                } else {
                    PlaylistControls()
                        .padding()
                }
                
                Spacer()
                //                        if let image = playlist.image {
                //
                //                                Image(uiImage: (UIImage(data: image) ?? defaultImage!))
                //                                    .resizable()
                //                                    .frame(width: 150, height: 150)
                //                                    .aspectRatio(contentMode: .fit)
                //                                    .clipShape(Circle())
                //
                //                        }
            }
            
            
            if let songs = playlist.songs {
                ScrollView {
                    ForEach(songs) { song in
                        SongRow(song: song)
                    }.onDelete(perform: { indexSet in
                        print("")
                    })
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
