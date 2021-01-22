//
//  CreatePlaylist.swift
//  Playlists
//
//  Created by Kaleb Page on 12/27/20.
//

import SwiftUI

struct PlaylistCreator: View {
    
    //MARK: TODO - Modally Present and Persist Data
    
    @State private var text = ""
    @Binding var isShowing: Bool
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var image: UIImage?
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = inputImage
    }
    
    func writePlaylistToDisk() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let archiveURL = documentsDirectory.appendingPathComponent("playlists").appendingPathExtension("plist")

        let propertyListEncoder = PropertyListEncoder()
        
        let newPlaylist = Playlist(name: text, songs: nil)
        
        let encodedPlaylist = try? propertyListEncoder.encode(newPlaylist)
        
        try? encodedPlaylist?.write(to: archiveURL, options: .noFileProtection)
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 30){
            
            //UIImagePickerController
            if let playlistImage = image {
                Image(uiImage: playlistImage)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .onTapGesture {
                        self.showingImagePicker = true
                    }
        
            } else {
                ZStack {
                    Image(systemName: "photo")
                        .scaleEffect(CGSize(width: 4.0, height: 4.0))
                        .frame(width: 100, height: 80, alignment: .center)
                        .foregroundColor(.gray)
                    Circle()
                        .frame(width: 150, height: 150, alignment: .center)
                        .foregroundColor(.gray)
                        .opacity(0.4)
                }.onTapGesture {
                    self.showingImagePicker = true
                }
            }
            
            TextField("Name", text: $text)
                .multilineTextAlignment(.center)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            NavigationLink(destination: PlaylistsView()) {
                Button(action: {
                                        
                    writePlaylistToDisk()
                    isShowing = false
                    
                }) {
                    Text("Done")
                        .foregroundColor(.blue)
                }
            }
        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
        
        
    }
    
    
    
}

//struct PlaylistCreator_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistCreator()
//    }
//}
