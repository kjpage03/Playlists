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
    @State var listShowing = false
    @State var backButtonDisabled = true
    @State var nextButtonDisabled = false
    var backButtonHidden: Bool
    //@State var nextClicked: Bool = false
    
    @EnvironmentObject var controller: MusicController
    @EnvironmentObject var searches: RecentSearches
    
    let player = MPMusicPlayerController.applicationQueuePlayer
    
    var body: some View {
        
        VStack {
            SearchBar(songs: $songs, listShowing: $listShowing)
            
            if searches.items.count > 0 && !listShowing {
                RecentSearchesView(songs: $songs, listShowing: $listShowing)
            } else {
                Spacer()
            }
            
            if listShowing {
                List {
                    ForEach(songs ?? [Song]()) { song in
                        ZStack {
                            
                            SongRow(showsButton: true, song: song)
                                .padding(5)
                                .onTapGesture {
                                    self.controller.items.removeAll()
                                    self.controller.items.insert(song, at: 0)
                                    self.controller.play()
                                    self.selection = song.id
                                }
                            
                            NavigationLink(destination: PlayView(), tag: song.id,selection: $selection) {
                                //SongRow(song: song)
                                //.padding(5)
                                EmptyView()
                            }
                            .opacity(0)
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                    }
                    
//                    HStack {
//                        Button(action: {
//                            //previous page
//                        }, label: {
//                            Text("Back")
//                                .foregroundColor(backButtonDisabled ? .gray : .blue)
//                        })
//                        .padding(.leading)
//                        .disabled(backButtonDisabled)
//                        .onTapGesture {
//                            backButtonDisabled = true
//                            nextButtonDisabled = false
//                            let searchController = SearchController()
//                            searchController.search(term: searches.items.reversed().first!.name) { (songs) in
//                                self.songs = songs
//                            }
//                        }
//                        Spacer()
//                        Button(action: {
//                            //next page
//                        }, label: {
//                            Text("Next")
//                                .foregroundColor(.blue)
//                        })
//                        .padding(.trailing)
//                        .onTapGesture {
//                            backButtonDisabled = false
//                            nextButtonDisabled = true
//                            var searchController = SearchController()
//                            searchController.isNextPage = true
//                            searchController.search(term: searches.items.reversed().first!.name) { (songs) in
//                                self.songs = songs
//                            }
//                        }
//                    }
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Spacer()
                            VStack {
                                Text("More")
                                Image(systemName: "chevron.down")
                            }
                            .foregroundColor(.blue)
                            Spacer()
                        }
                        
                    })
                    .onTapGesture {
                        var searchController = SearchController()
                        searchController.limit = 50
                        searchController.search(term: searches.items.reversed().first!.name) { (songs) in
                            self.songs = songs
                        }
                    }
                }
                
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

