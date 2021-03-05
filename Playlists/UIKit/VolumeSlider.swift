//
//  VolumeView.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/13/21.
//

import SwiftUI
import UIKit
import MediaPlayer

struct VolumeSlider: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some MPVolumeView {
        MPVolumeView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}


