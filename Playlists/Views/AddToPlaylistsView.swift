//
//  PlaylistsView.swift
//  Playlists
//
//  Created by Kaleb Page on 12/27/20.
//

import SwiftUI

struct AddToPlaylistsView: View {
    
    @State var createPlaylistShowing: Bool = false
    @EnvironmentObject var playlistController: PlaylistController
    private let columnCount = 2
    let layout = [GridItem(.adaptive(minimum: 150))]
    var song: Song
    @Binding var isPresented: Bool
    
    var body: some View {
               
        if playlistController.items.count == 0 {
            Text("You don't have any playlists.")
                .fontWeight(.light)
                .padding()
                
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
        } else {
            ScrollView {
            LazyVGrid(columns: layout, spacing: 20) {
                ForEach(playlistController.items) { item in
                    PlaylistRep(playlist: item, song: song, isPresented: $isPresented)
                }
            }
            .padding()
                
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
}

//struct AddToPlaylistsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        AddToPlaylistsView().environmentObject(PlaylistController())
//    }
//}
