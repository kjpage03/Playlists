//
//  SetupView.swift
//  Playlists
//
//  Created by Kaleb Page on 1/5/21.
//

import SwiftUI
import StoreKit

struct SetupView: UIViewControllerRepresentable {
    
    @Binding var hasSubscription: Bool
    
    func makeUIViewController(context: Context) -> some SetupViewController {
        let setupController = SetupViewController(hasSub: $hasSubscription)
        return setupController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

