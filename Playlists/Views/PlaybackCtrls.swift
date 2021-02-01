//
//  playControl.swift
//  Playlists
//
//  Created by Kaleb Page on 12/17/20.
//

import SwiftUI

struct PlayControl: View {

    @Binding var isPaused: Bool
    @Binding var didSkip: Bool
    @Binding var didGoBack: Bool
    @EnvironmentObject var controller: MusicController
    
    var body: some View {
        
        
        HStack(alignment: .center, spacing: 20) {
            
            Button(action: {
                
                //Back
                didGoBack = true
                
            }) {
                Image("Back")
                    .scaleEffect(CGSize(width: 0.1, height: 0.1))
                    .padding(-220)
            }
            

            Button(action: {
                
                withAnimation(.easeInOut(duration: 0.2)) {
                    
//                    self.isPaused.toggle()

                    if controller.musicPlayer.playbackState == .paused {
                        self.isPaused = false
                    } else if controller.musicPlayer.playbackState == .playing {
                        self.isPaused = true
                    }
                    
                }

                //pause/play
                
            }) {
//                Image(isPaused ? "Play" : "Pause")
//                    .scaleEffect(isPaused ? CGSize(width: 0.18, height: 0.18) : CGSize(width: 0.23, height: 0.23))
//                        .padding(-200)
                
                Image(controller.musicPlayer.playbackState == .paused ? "Play" : "Pause")
                    .scaleEffect(controller.musicPlayer.playbackState == .paused ? CGSize(width: 0.18, height: 0.18) : CGSize(width: 0.23, height: 0.23))
                        .padding(-200)
                        
            }
            
            Button(action: {
                
                //Skip
                didSkip = true
                
            }) {
                    Image("Back")
                        .scaleEffect(CGSize(width: 0.1, height: 0.1))
                        .padding(-220)
                        .rotationEffect(.degrees(180))
                        
            }
            
        }
    }
    
    
}


struct PressedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(CGSize(width: 0.2, height: 0.2))
    }
    
    
}


//struct playControl_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayControl()
//            .previewLayout(.fixed(width: 300, height: 100))
//    }
//}
