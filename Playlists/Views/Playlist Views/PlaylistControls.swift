//
//  PlaylistControls.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/26/21.
//

import SwiftUI

struct PlaylistControls: View {
    
    
    
    var body: some View {
        HStack(spacing: 20) {
                
                Button(action: {
                    //play queue
                }, label: {
                    ZStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.black)
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                        .opacity(0.8)
                    Circle()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.gray)
                        .opacity(0.7)
                        .shadow(radius: 5)
                    }
                })

                Button(action: {
                    //shuffle queue
                }, label: {
                    ZStack {
                    Image(systemName: "shuffle")
                        .foregroundColor(.black)
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                        .opacity(0.8)
                        Circle()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.gray)
                            .opacity(0.7)
                            .shadow(radius: 5)
                    }
                })
                                
                Button(action: {
                    //add songs
                }, label: {
                    ZStack {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                        .opacity(0.8)
                        Circle()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.gray)
                            .opacity(0.7)
                            .shadow(radius: 5)
                    }
                })
                
            
        }
    }
}

struct PlaylistControls_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistControls()
    }
}
