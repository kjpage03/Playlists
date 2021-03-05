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
    @ObservedObject var playlistController = PlaylistController()
    @State var isInQueue = false
    @Binding var specialID: String
    var showsButton: Bool
    var textColor: Color?
    
    var song: Song
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                ImageView(withURL: song.attributes.artwork.url, height: song.attributes.artwork.height, width: song.attributes.artwork.width, frameHeight: 50, frameWidth: 50, song: song)
                
                
                VStack(alignment: .leading) {
                    
                    if let rating = song.attributes.contentRating?.capitalized {
                        Text(song.attributes.name).bold() + Text(" (\(rating))")
                            .foregroundColor(textColor != nil ? textColor : .none)
                    } else {
                        Text(song.attributes.name).bold()
                            .foregroundColor(textColor != nil ? textColor : .none)
                        
                    }
                    
                    Text("\(song.attributes.artistName) - \(song.attributes.albumName)")
                        .foregroundColor(textColor != nil ? textColor : .none)
                        .fontWeight(.light)
                    
                }
                
                Spacer()
                
                if showsButton {
                    Button(action: {
                        //Back
                        //                withAnimation(.easeInOut) {
                        //                    optionsShowing.toggle()
                        //                }
                        withAnimation(.easeInOut(duration: 0.5)) {
//                            showOptions.toggle()
                            if specialID != song.id {
                                specialID = song.id
                            } else {
                                specialID = String()
                            }
                        }
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.gray)
                            .imageScale(.medium)
                            .rotationEffect(.degrees(specialID == song.id ? 270 : 0))
                            .animation(.easeInOut)
                        
                    }
                    .frame(width: 40, height: 50, alignment: .center)
                    .onTapGesture {
                                                
                        withAnimation(.easeInOut(duration: 0.3)) {
                            
                            if specialID != song.id {
                                specialID = song.id
                            } else {
                                specialID = String()
                            }
                            
                        }
                    }
                }
            }
            
            if specialID == song.id {
                OptionsView(song: song)
            }
        }
    }
}

//struct SongRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SongRow(song: Playlist.testSong)
//            .previewLayout(.fixed(width: 300, height: 70))
//    }
//}


