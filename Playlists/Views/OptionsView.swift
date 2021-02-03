//
//  OptionsView.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/27/21.
//

import SwiftUI
import MediaPlayer

struct OptionsView: View {
    @EnvironmentObject var controller: MusicController
    @State var playlistsPresented = false
    @State var queueTapped = false
    
    var song: Song
    
    @State var isInQueue = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            GroupBox {
                
                Text("\(Image(systemName: "music.note.list")) Add to Playlist")
                    .frame(maxWidth: .infinity)
            }
            .onTapGesture {
                playlistsPresented = true
            }
            .sheet(isPresented: $playlistsPresented, content: {
                
                AddToPlaylistsView(song: song, isPresented: $playlistsPresented)
                
            })
            
            Divider()
            
            GroupBox {
                Text("\(Image(systemName: "list.number")) Add to Queue")
                    .frame(maxWidth: .infinity)
                    .opacity(isInQueue ? 0.5 : 1.0)
                    .disabled(isInQueue)
                    .animation(.easeIn)
            }
            .onTapGesture {
                
                isInQueue = true
                controller.newItem = song
                
            }
        }
        
        .onAppear(perform: {
            for song in controller.items {
                if song.id == self.song.id {
                    isInQueue = true
                }
            }
        })
    }
}

struct OptionsView_Previews: PreviewProvider {
    
    static var previews: some View {
        OptionsView(song: Playlist.testSong).environmentObject(MusicController())
    }
}
