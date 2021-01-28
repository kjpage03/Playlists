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
    var song: Song
    
    var body: some View {
        GroupBox {
            Text("\(Image(systemName: "music.note.list")) Add to Playlist")
                .onTapGesture {
                    playlistsPresented = true
                }
                .sheet(isPresented: $playlistsPresented, content: {
                    EmptyView()
                })
            Divider()
            Text("\(Image(systemName: "list.number")) Add to Queue")
                .onTapGesture {
//                    controller.items.removeAll()
//                    controller.items.append(song)
                    controller.newItem = song
//                    controller.refreshMusicPlayer()
//                    print("NEW QUEUE: \(controller.items)")
                }
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView(song: Playlist.testSong)
    }
}
