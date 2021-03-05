//
//  PlaylistEditor.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/25/21.
//

import SwiftUI

struct PlaylistEditor: View {
    
    var playlist: Playlist
    @State private var nameText = ""
    @State private var descriptionText = ""
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var image: UIImage?
    @Binding var editShowing: Bool
    @EnvironmentObject var playlistController: PlaylistController
    @State var didDelete = false
    @State var indexOfCurrentTheme = 0
    var defaultImage = UIImage(named: "gray-square")
    @EnvironmentObject var themeController: ThemeController
    @Binding var didFinish: Bool

    var startingIndex: Int {
        var finalIndex = 0
        for (index, theme) in themeController.themes.enumerated() {
            if theme.id == playlist.theme.id {
                finalIndex = index
            }
        }
        return finalIndex
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = inputImage
    }
    
    func setBackground() {
        UITableView.appearance().backgroundColor = themeController.themes[indexOfCurrentTheme].bgColor.uiColor
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 30) {
                
                if let playlistImage = UIImage(data: (playlist.image ?? defaultImage!.pngData())!) {
                    Image(uiImage: image != nil ? image! : playlistImage)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                }
                
                TextField("Name", text: $nameText)
                    .multilineTextAlignment(.center)
                //                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Description", text: $descriptionText)
                    .multilineTextAlignment(.center)
                
                ThemePicker(startingIndex: startingIndex, currentTheme: $indexOfCurrentTheme)
                    
                VStack {
                    Spacer()
                    Button(action: {
                        
                        for (index, item) in playlistController.items.enumerated() {
                            if item.id == playlist.id {
                                if image != nil {
                                    playlistController.items[index].image = image?.pngData()
                                }
                                playlistController.items[index].name = nameText
                                playlistController.items[index].theme = themeController.themes[indexOfCurrentTheme]
                                if descriptionText != "" {
                                    playlistController.items[index].description = descriptionText
                                } else {
                                    playlistController.items[index].description = nil
                                }
                            }
                        }
//                        parent.setBackground()
                        didFinish = false
                        showingImagePicker = false
                        editShowing = false
                        
                    }) {
                        Text("Done")
                            .foregroundColor(.blue)
                    }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: $inputImage)
                    }
                    
                    Spacer()
                    NavigationLink(destination: PlaylistsView(), isActive: $didDelete) {
                        Button(action: {
                            //remove playlist from items array somehow
                            for (index, item) in playlistController.items.enumerated() {
                                if item.id == playlist.id {
                                    playlistController.items.remove(at: index)
                                }
                            }
                            
                            editShowing = false
                            didDelete = true
                            //think we got it
                        }, label: {
                            Text("Delete Playlist")
                                .accentColor(.red)
                        })
                    }
                    Spacer()
                }
                
            }
            .onAppear(perform: {
                nameText = playlist.name
                if let description = playlist.description {
                    descriptionText = description
                }
        })
        }
        
    }
}

//struct PlaylistEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistEditor(playlist: Playlist.testPlaylist)
//    }
//}
