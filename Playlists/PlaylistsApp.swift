//
//  PlaylistsApp.swift
//  Playlists
//
//  Created by Kaleb Page on 12/17/20.
//

import SwiftUI
import StoreKit
import MediaPlayer

@main

struct PlaylistsApp: App {
    
    @ObservedObject var checker = SubscriptionChecker()
    @State var hasSubscription = Bool()
    @ObservedObject var controller = MusicController()
    @ObservedObject var playlistController = PlaylistController()

    
//    var queue = Queue()
    
    var body: some Scene {
        
        WindowGroup {
            
//            if hasSubscription {
//
//            } else {
//                SetupView(hasSubscription: $hasSubscription)
//            }
            
            PlayView().environmentObject(controller)
                .environmentObject(playlistController)

            
            /*PlayView(hasSub: $hasSubscription)
                .onReceive(checker.dataPublisher, perform: { hasSub in
                self.hasSubscription = hasSub
            })*/
            
                
            }
        }
    }

