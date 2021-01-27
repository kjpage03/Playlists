//
//  PlaylistRow.swift
//  Playlists
//
//  Created by Kaleb Page on 12/27/20.
//

import SwiftUI

struct PlaylistRow: View {
    
    var playlist: Playlist
    
    var body: some View {
        VStack {
            
            if let playlistImage = UIImage(data: playlist.image ?? Data()) {
                
                NavigationLink(destination: PlaylistView(playlist: playlist)) {
                    Image(uiImage: playlistImage)
                        .resizable()
                        .frame(width: 140, height: 140)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .overlay(Circle().stroke(Color.black, lineWidth: 0.5))

                }
                
                } else {
                    
                    NavigationLink(destination: PlaylistView(playlist: playlist)) {
                        Image("gray-square")
                            .frame(width: 140, height: 140)
                            .scaleEffect(CGSize(width: 0.2, height: 0.2))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .overlay(Circle().stroke(Color.black, lineWidth: 0.5))
                    }
                }
                
            
            Text(playlist.name)
                
        }
    }
}

struct PlaylistRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistRow(playlist: Playlist.testPlaylist)
//            .previewLayout(.fixed(width: 300, height: 70))
    }
}
