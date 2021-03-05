//
//  ImageView.swift
//  Playlists
//
//  Created by Kaleb Page on 1/4/21.
//

import SwiftUI
import Combine

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    @State var showSpinner: Bool = true
    var frameHeight: Int
    var frameWidth: Int
    var song: Song
    @EnvironmentObject var playlistController: PlaylistController
    
    init(withURL url: String, height: Int, width: Int, frameHeight: Int, frameWidth: Int, song: Song) {
        
        var finalUrl = url
        finalUrl = url.replacingOccurrences(of: "{w}x{h}", with: "\(width)x\(height)")
        imageLoader = ImageLoader(urlString: finalUrl)
        //print(finalUrl)
        
        self.frameHeight = frameHeight
        self.frameWidth = frameWidth
        self.song = song
    }
    
    var body: some View {
        
        if let image = song.photo {
            Image(uiImage: UIImage(data: image)!)
                
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: CGFloat(frameWidth), height: CGFloat(frameHeight))
            
        } else {
                
        VStack {
                if showSpinner {
                    ProgressView()
                        .frame(width: CGFloat(frameWidth), height: CGFloat(frameHeight))
                        .scaleEffect(CGSize(width: frameWidth == 50 ? 1 : 3, height: frameHeight == 50 ? 1 : 3))
                } else {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: CGFloat(frameWidth), height: CGFloat(frameHeight))
                }
                
        }.onReceive(imageLoader.dataPublisher, perform: { data in
            //THIS
            for (pIndex, item) in playlistController.items.enumerated() {
                for (sIndex, song) in item.songs!.enumerated() {
                    if song.uniqueID == self.song.uniqueID {
                        playlistController.items[pIndex].songs![sIndex].photo = data
                    }
                }
            }
            
            showSpinner = false
            self.image = UIImage(data: data) ?? UIImage()
        })
    }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "https://images-na.ssl-images-amazon.com/images/I/71nYpz%2B%2BVCL._SL1400_.jpg", height: 1000, width: 1000, frameHeight: 50, frameWidth: 50, song: Playlist.testSong)
    }
}
