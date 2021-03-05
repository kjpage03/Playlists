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
    @State var searchIsActive = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @Binding var isActive: Bool
    @State var isShowing = true
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
                    presentationMode.wrappedValue.dismiss()
                    isActive = true
                        
                    }, label: {
                        ZStack {
                        Image(systemName: "play.fill")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .scaleEffect(CGSize(width: 1.5, height: 1.5))
                            .opacity(1.0)
                        Circle()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.gray)
                            .opacity(0.7)
                            .shadow(radius: 5)
                        }
                })
            }
            
//            NavigationLink(destination: PlayView(), isActive: $shuffleIsActive) {
                Button(action: {
                    //shuffle queue
                    if let songs = playlist.songs {
                        controller.items.removeAll()
                        controller.musicPlayer.stop()
                        controller.items = songs.shuffled()
                        controller.play()
                        
                    }
                    shuffleIsActive = true
                    presentationMode.wrappedValue.dismiss()
                    isActive = true

                }, label: {
                    ZStack {
                    Image(systemName: "shuffle")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                        .opacity(1.0)
                        Circle()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.gray)
                            .opacity(0.7)
                            .shadow(radius: 5)
                    }
                })
//            }
                                
            
//            NavigationLink(destination: SearchView(backButtonHidden: false),
//                isActive: $searchIsActive){
                Button(action: {
                        //add songs
                    UITableView.appearance().backgroundColor = UIColor.systemBackground

                    searchIsActive = true
                    
                    }, label: {
                        ZStack {
                        Image(systemName: "plus")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .scaleEffect(CGSize(width: 1.5, height: 1.5))
                            .opacity(1.0)
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(.gray)
                                .opacity(0.7)
                                .shadow(radius: 5)
                        }
                })
                .sheet(isPresented: $searchIsActive, content: {
                    SearchView(backButtonHidden: true, hasDragIndicator: true)
                })
//            }
                
            
        }
    }
}

//struct PlaylistControls_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistControls(playlist: Playlist.testPlaylist)
//    }
//}
