//
//  SongRow.swift
//  Playlists
//
//  Created by Kaleb Page on 12/20/20.
//

import SwiftUI
import UIKit
import Combine
import MediaPlayer


struct SongRow: View {
    
    @State var showOptions = false
    @EnvironmentObject var controller: MusicController
    
    var song: Song
    
    var body: some View {
        
        VStack {
    
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
                withAnimation(.easeInOut(duration: 0.5)) {
                    showOptions.toggle()

                }
            }) {
                
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .imageScale(.medium)
                    .rotationEffect(.degrees(showOptions ? 270 : 0))
                    .animation(.easeInOut)
                    
                }
            .frame(width: 40, height: 50, alignment: .center)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showOptions.toggle()

                }
                
//                controller.items.append(song)
//                controller.refreshMusicPlayer()
//                print("NEW QUEUE: \(controller.items)")
            }
            
            
            }
            if showOptions {
                OptionsView(song: song)
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


