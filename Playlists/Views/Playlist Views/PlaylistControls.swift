//
//  PlaylistControls.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/26/21.
//

import SwiftUI

struct PlaylistControls: View {
    
    @EnvironmentObject var controller: MusicController
    @State var playIsActive = false
    @State var shuffleIsActive = false
    @Environment(\.colorScheme) var colorScheme
    var playlist: Playlist
    
    var body: some View {
        HStack(spacing: 20) {
            
            NavigationLink(destination: PlayView(), isActive: $playIsActive) {
                Button(action: {
                        //play queue
                        if let songs = playlist.songs {
                            controller.items = songs
                            controller.play()
                        }
                    
                    playIsActive = true
                        
                    }, label: {
                        ZStack {
                        Image(systemName: "play.fill")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .scaleEffect(CGSize(width: 1.5, height: 1.5))
                            .opacity(0.8)
                        Circle()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.gray)
                            .opacity(0.7)
                            .shadow(radius: 5)
                        }
                })
            }
            
            NavigationLink(destination: PlayView(), isActive: $shuffleIsActive) {
                Button(action: {
                    //shuffle queue
                    if let songs = playlist.songs {
                        
                        controller.items = songs.shuffled()
                        controller.play()
                        
                    }
                    shuffleIsActive = true
                    
                }, label: {
                    ZStack {
                    Image(systemName: "shuffle")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                        .opacity(0.8)
                        Circle()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.gray)
                            .opacity(0.7)
                            .shadow(radius: 5)
                    }
                })
            }
                                
                Button(action: {
                    //add songs
                }, label: {
                    ZStack {
                    Image(systemName: "plus")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                        .opacity(0.8)
                        Circle()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.gray)
                            .opacity(0.7)
                            .shadow(radius: 5)
                    }
                })
                
            
        }
    }
}

struct PlaylistControls_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistControls(playlist: Playlist.testPlaylist)
    }
}
