//
//  PlaylistView.swift
//  Playlists
//
//  Created by Kaleb Page on 12/20/20.
//

import SwiftUI


struct PlaylistView: View {
    
    var playlist: Playlist 
    @EnvironmentObject var playlistController: PlaylistController
    @EnvironmentObject var controller: MusicController
    @EnvironmentObject var themeController: ThemeController
    @Environment(\.presentationMode) var presentationMode
    @State var selection: String? = nil
    @State var editShowing = false
    @State var specialID = String()
    @State var didChange: Bool = false
    @Binding var finishedEditing: Bool
    @Binding var isActive: Bool
    var defaultImage = UIImage(named: "gray-square")
    
//    func setBackground() {
//        DispatchQueue.main.async {
//            UITableView.appearance().backgroundColor = playlist.theme.bgColor.uiColor
//        }
//    }
    
    var body: some View {
        
       
                
        ZStack {
            Color(playlist.theme.bgColor.uiColor)
                .ignoresSafeArea()
            
            VStack {
                HStack() {
                    Spacer()
                    if let image = playlist.image {
                        Image(uiImage: (UIImage(data: image) ?? defaultImage!))
                            .resizable()
                            .frame(width: 115, height: 115)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .offset(x: 0, y: 15)
                    }
                    
                }.frame(width: 350, height: 0)
                
                HStack() {
                    if let description = playlist.description {
                        VStack(alignment: .leading) {
                            PlaylistControls(isActive: $isActive, playlist: playlist)
                                .padding()
                            Text(description)
                                .fontWeight(.light)
                                .padding(.horizontal)
                        }
                    } else {
                        PlaylistControls(isActive: $isActive, playlist: playlist)
                            .padding()
                    }
                    
                    Spacer()
                }
                
                if playlist.songs!.count > 0 {
                    
                        
//                        List {
//                                ForEach(playlist.songs!) { song in
//
//                                    ZStack {
//
//                                        SongRow(specialID: $specialID, showsButton: false, textColor: Color(playlist.theme.acColor.uiColor), song: song)
//                                            .padding(5)
//                                            .onTapGesture {
//                                                self.controller.items.removeAll()
//                                                self.controller.items.insert(song, at: 0)
//                                                self.controller.play()
//                                                self.selection = song.id
//                                            }
//
//
//                                        NavigationLink(destination: PlayView(), tag: song.id,selection: $selection) {
//                                            //SongRow(song: song)
//                                            //.padding(5)
//                                            EmptyView()
//                                        }
//                                        .opacity(0)
//                                        .buttonStyle(PlainButtonStyle())
//
//                                    }
//
//                                }
//                                .onDelete(perform: { indexSet in
//
//                                    for (index, item) in playlistController.items.enumerated() {
//                                        if self.playlist.id == item.id {
//                                            playlistController.items[index].songs?.remove(atOffsets: indexSet)
//                                        }
//                                    }
//
//                                })
//                                .listRowBackground(Color(playlist.theme.bgColor.uiColor))
//
//                            }
                    SongList(playlist: playlist)
                            
                            .navigationBarTitle(playlist.name, displayMode: .large)
                            .navigationBarItems(trailing: Button(action: {
                                print("Edit icon pressed...")
                                editShowing = true
                            }) {
                                Image(systemName: "pencil").imageScale(.large)
                            })
                            .sheet(isPresented: $editShowing, content: {
                                
                                PlaylistEditor(playlist: playlist, editShowing: $editShowing, didFinish: $finishedEditing)
                                    .modifier(SystemServices())
                                    
                        })
                        .onDisappear(perform: {
                            UITableView.appearance().backgroundColor = UIColor.systemBackground
                        })
                    

//                            .onAppear(perform: {
//                                UITableView.appearance().backgroundColor = playlist.theme.bgColor.uiColor
//                                    })
//                                    .onDisappear(perform: {
//                                        UITableView.appearance().backgroundColor = UIColor.systemBackground
//                                    })
                                                
                            
//                            .navigationBarTitle(playlist.name, displayMode: .large)
//                            .navigationBarItems(trailing: Button(action: {
//                                print("Edit icon pressed...")
//                                editShowing = true
//                            }) {
//                                Image(systemName: "pencil").imageScale(.large)
//                            })
//                            .sheet(isPresented: $editShowing, content: {
//
//                                PlaylistEditor(playlist: playlist, editShowing: $editShowing)
//
//                        })
                    
                    
                    //                        Color(playlist.theme.bgColor.uiColor)
                    //                            .ignoresSafeArea()
                    //                    }
                    
                    
                } else {
                    
                    VStack {
                        Spacer()
                        Text("No songs have been added to this playlist.")
                            .fontWeight(.light)
                        Spacer()
                    }
                    
                    .navigationBarTitle(Text(playlist.name), displayMode: .large)
                    .navigationBarItems(trailing: Button(action: {
                        print("Edit icon pressed...")
                        editShowing = true
                    }) {
                        Image(systemName: "pencil").imageScale(.large)
                    })
                    .sheet(isPresented: $editShowing, content: {
                        
                        PlaylistEditor(playlist: playlist, editShowing: $editShowing, didFinish: $finishedEditing)
                        
                    })
                    
                }
                
            }
        }
        
        
    }
}

//struct PlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistView(playlist: Playlist.testPlaylist)
//    }
//}
