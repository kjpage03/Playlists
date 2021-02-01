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
    @EnvironmentObject var controller: MusicController
    @State var selection: String? = nil
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
                    VStack(alignment: .leading) {
                        PlaylistControls(playlist: playlist)
                            .padding()
                        Text(description)
                            .fontWeight(.light)
                            .padding(.horizontal)
                    }
                } else {
                    PlaylistControls(playlist: playlist)
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
                List {
                    ForEach(songs) { song in
//                        SongRow(showsButton: false, song: song)
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 5)
                        
                        ZStack {
                            
                            SongRow(showsButton: false, song: song)
                                .padding(5)
                                .onTapGesture {
                                    self.controller.items.removeAll()
                                    self.controller.items.insert(song, at: 0)
                                    self.controller.play()
                                    self.selection = song.id
                                }
                            
                            NavigationLink(destination: PlayView(), tag: song.id,selection: $selection) {
                                //SongRow(song: song)
                                //.padding(5)
                                EmptyView()
                            }
                            .opacity(0)
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                        
                    }.onDelete(perform: { indexSet in
                        
                        for (index, item) in playlistController.items.enumerated() {
                            if self.playlist.id == item.id {
                                playlistController.items[index].songs?.remove(atOffsets: indexSet)
                            }
                        }
                        
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
