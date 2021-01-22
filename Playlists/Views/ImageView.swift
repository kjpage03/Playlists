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
    
    init(withURL url: String, height: Int, width: Int, frameHeight: Int, frameWidth: Int) {
        
        var finalUrl = url
        finalUrl = url.replacingOccurrences(of: "{w}x{h}", with: "\(width)x\(height)")
        imageLoader = ImageLoader(urlString: finalUrl)
        //print(finalUrl)
        
        self.frameHeight = frameHeight
        self.frameWidth = frameWidth
    }
    
    var body: some View {
                
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
            showSpinner = false
            self.image = UIImage(data: data) ?? UIImage()
        })
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "https://images-na.ssl-images-amazon.com/images/I/71nYpz%2B%2BVCL._SL1400_.jpg", height: 1000, width: 1000, frameHeight: 50, frameWidth: 50)
    }
}
