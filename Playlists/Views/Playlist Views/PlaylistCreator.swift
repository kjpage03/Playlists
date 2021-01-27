//
//  CreatePlaylist.swift
//  Playlists
//
//  Created by Kaleb Page on 12/27/20.
//

import SwiftUI

struct PlaylistCreator: View {
    
    //MARK: TODO - Modally Present and Persist Data
    
    @State private var nameText = ""
    @State private var descriptionText = ""
    @Binding var isShowing: Bool
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var image: UIImage?
    @EnvironmentObject var playlistController: PlaylistController
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = inputImage
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
            
            TextField("Name", text: $nameText)
                .multilineTextAlignment(.center)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Description", text: $descriptionText)
                .multilineTextAlignment(.center)
            
            NavigationLink(destination: PlaylistsView()) {
                
                //disable if text fields are empty
                Button(action: {
                                        
                    playlistController.items.append(Playlist(name: nameText, description: descriptionText == "" ? nil : descriptionText, songs: [Song(id: "", type: "", attributes: Attributes(albumName: "Blue Album", artistName: "Weezer", artwork: Artwork(height: 100, width: 100, url: ""), name: "Say It Ain't So", url: nil, durationInMillis: 259000))], image: image?.pngData()))
                    isShowing = false
                    
                }) {
                    Text("Done")
                        .foregroundColor(.blue)
                }
                
            }
        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
        .scaleEffect(CGSize(width: 1.0, height: 1.0))
        
        
    }
    
    
    
}

//struct PlaylistCreator_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistCreator().environmentObject(PlaylistController())
//    }
//}
