//
//  SongRow.swift
//  Playlists
//
//  Created by Kaleb Page on 12/20/20.
//

import SwiftUI
import UIKit
import Combine



struct SongRow: View {
    
//    @Binding var optionsShowing: Bool
    
    @EnvironmentObject var controller: MusicController
    
    var song: Song
    
    var body: some View {
    
        //ellipsis
        ZStack {
            HStack{
                Spacer()
                
//                if optionsShowing {
//                    Options()
//                        .offset(x: -30, y: -80)
//                }
            }
            
            
        HStack {
            
            ImageView(withURL: song.attributes.artwork.url, height: song.attributes.artwork.height, width: song.attributes.artwork.width, frameHeight: 50, frameWidth: 50)
                
            
            VStack(alignment: .leading) {
                
                Text(song.attributes.name)
                    .bold()
                Text("\(song.attributes.artistName) - \(song.attributes.albumName)")
                    .fontWeight(.light)
            }
            
            Spacer()
            
            Button(action: {
                //Back
//                withAnimation(.easeInOut) {
//                    optionsShowing.toggle()
//                }
            }) {
                
                Image(systemName: "plus")
                    .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    .rotationEffect(.degrees(90))
                    .animation(.easeInOut)
                    
                    
                }
            .frame(width: 40, height: 50, alignment: .center)
            .onTapGesture {
                controller.items.append(song)
                controller.refreshMusicPlayer()
                print("NEW QUEUE: \(controller.items)")
            }
            
            }
        }
    }
}

struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow(song: Playlist.testSong)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}


