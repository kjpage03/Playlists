//
//  QueueView.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/3/21.
//

import SwiftUI
import MediaPlayer

struct QueueView: View {
    
    @EnvironmentObject var musicController: MusicController
    @Environment(\.colorScheme) var colorScheme
    @State var specialID = ""
    @State var index = 0
    @State var songs: [Song] = []
    @State var currentSong: [Song] = []
    
//    init() {
//        UITableView.appearance().backgroundColor = UIColor.systemBackground
//    }
    
    var body: some View {
        VStack {
            DragIndicator()
            HStack {
                Image(systemName: "list.number")
                    .scaleEffect(CGSize(width: 1.25, height: 1.25))
                Text("Current Queue")
                    .font(.system(size: 20.0, weight: .medium, design: Font.Design.default))
            }
            Divider()
            
            List {
                ForEach(musicController.items.indices, id: \.self) { songIndex in
                    
                    HStack {
                        Text("\(songIndex+1)")
                        if musicController.currentSong.id == musicController.items[songIndex].id {
                            SongRow(specialID: $specialID, showsButton: false, song: musicController.items[songIndex])
                                .padding(5)
                                .background(colorScheme == .dark ? Color.white.opacity(0.3) : Color.gray.opacity(0.3))
                            
                        } else {
                            SongRow(specialID: $specialID, showsButton: false, song: musicController.items[songIndex])
                                .padding(5)
                        }
                    }
                }.onDelete(perform: { indexSet in
                    
                    musicController.items.remove(atOffsets: indexSet)
                })
                
            }
        }
    }
}

struct QueueView_Previews: PreviewProvider {
    static var previews: some View {
        QueueView()
    }
}

