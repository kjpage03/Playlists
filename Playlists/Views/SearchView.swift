//
//  SearchView.swift
//  Playlists
//
//  Created by Kaleb Page on 12/17/20.
//

import SwiftUI
import SwiftJWT
import MediaPlayer

struct SearchView: View {
    
    @State var songs: [Song]?
    @State var showNext: Bool = false
    @State var showOptions: Bool = false
    @State var selection: String? = nil
    var backButtonHidden: Bool
    //@State var nextClicked: Bool = false
    
    @EnvironmentObject var controller: MusicController
    
    let player = MPMusicPlayerController.applicationQueuePlayer
    
    var body: some View {
        
        VStack {
            SearchBar(songs: $songs)
                
                List {
                    
                    ForEach(songs ?? [Song]()) { song in
                        ZStack {

                            SongRow(song: song)
                                .padding(5)
                                .onTapGesture {
                                    self.controller.items.removeAll()
                                    self.controller.items.insert(song, at: 0)
                                    self.controller.musicPlayer.stop()
                                    self.controller.musicPlayer.prepareToPlay()
                                    self.controller.musicPlayer.play()
                                    self.selection = song.id
                                }
                            
                            NavigationLink(destination: PlayView(), tag: song.id,selection: $selection) {
//                                SongRow(song: song)
//                                    .padding(5)
                                EmptyView()
                            }
                                .opacity(0)
                                .buttonStyle(PlainButtonStyle())
                                
                        }
                    }
                    
                    //if showNext {
                        /*HStack {
                            Spacer()
                            Button(action: {
                                //nextClicked = true
                            }, label: {
                                Next()
                            })
                            .frame(width: 100, height: 100, alignment: .center)
                            
                            Spacer()
                        }*/
                    //}
                        
                }
            
            
        }
        .navigationBarTitle("Search", displayMode: .inline)
        .navigationBarBackButtonHidden(backButtonHidden)
    }
    
    
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(songs: [Playlist.testSong])
//    }
//}

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

