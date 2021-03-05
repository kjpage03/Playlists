//
//  PlaylistRow.swift
//  Playlists
//
//  Created by Kaleb Page on 12/27/20.
//

import SwiftUI

struct PlaylistRep: View {
    
    @EnvironmentObject var playlistController: PlaylistController
    var playlist: Playlist
    var song: Song
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            
            if let playlistImage = UIImage(data: playlist.image ?? Data()) {
                
                Button(action: {
                    for (index, item) in playlistController.items.enumerated() {
                        if item.id == self.playlist.id {
                            playlistController.items[index].songs?.append(song)
                        }
                    }
                    isPresented = false
                }, label: {
                    Image(uiImage: playlistImage)
                        .resizable()
                        .frame(width: 140, height: 140)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .overlay(Circle().stroke(Color.black, lineWidth: 0.5))
                })
                
            } else {
                
//                NavigationLink(destination: PlaylistView(playlist: playlist, finishedEditing: $isPresented)) {
                    Image("gray-square")
                        .frame(width: 140, height: 140)
                        .scaleEffect(CGSize(width: 0.2, height: 0.2))
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .overlay(Circle().stroke(Color.black, lineWidth: 0.5))
//                }
            }
            
            
            Text(playlist.name)
            
        }
    }
}

//struct PlaylistRep_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistRep(playlist: Playlist.testPlaylist)
//                    .previewLayout(.fixed(width: 300, height: 70))
//    }
//}
