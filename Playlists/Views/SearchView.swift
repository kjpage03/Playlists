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
                            NavigationLink(destination: LazyView(PlayView(song: song))) {
                                    EmptyView()
                                        
                                }
                            .onTapGesture {
                                print("Navigation link tapped")
                                controller.items.insert(song, at: 0)
                                print(controller.items)
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
    }
    
    
}

struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchView(songs: [Playlist.testSong])
    }
}

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

