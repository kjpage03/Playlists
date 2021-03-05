//
//  PlaylistsView.swift
//  Playlists
//
//  Created by Kaleb Page on 12/27/20.
//

import SwiftUI

struct PlaylistsView: View {
    
    @State var createPlaylistShowing: Bool = false
    @State var isActive = false
    @EnvironmentObject var playlistController: PlaylistController
//    @Environment var popController: PopController
    @Environment(\.presentationMode) var presentationMode
    private let columnCount = 2
    let layout = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        
        let isActive = Binding<Bool>(
            get: {
                self.isActive
            }, set: {
                self.isActive = $0
                presentationMode.wrappedValue.dismiss()
            })
               
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
                    PlaylistRow(playlist: item, isActive: isActive)
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

//struct PlaylistsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        PlaylistsView().environmentObject(PlaylistController())
//    }
//}
