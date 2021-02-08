//
//  QueueView.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/3/21.
//

import SwiftUI

struct QueueView: View {
    
    @EnvironmentObject var musicController: MusicController
    @State var specialID = ""
    
    var body: some View {
        
        List {
            ForEach(musicController.items) { song in
                SongRow(specialID: $specialID, showsButton: false, song: song)
                    .padding(5)
            }.onDelete(perform: { indexSet in
                musicController.items.remove(atOffsets: indexSet)
            })
            
        }
    }
}

struct QueueView_Previews: PreviewProvider {
    static var previews: some View {
        QueueView()
    }
}
