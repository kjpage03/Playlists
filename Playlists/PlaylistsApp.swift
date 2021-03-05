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
    
    @StateObject var controller = MusicController()
    @StateObject var playlistController = PlaylistController()
    @StateObject var searches = RecentSearches()
    @StateObject var themeController = ThemeController()
//    @ObservedObject var colorController = ColorController()
    
//    var queue = Queue()
    
    var body: some Scene {
        
        WindowGroup {
            
//            if hasSubscription {
//
//            } else {
//                SetupView(hasSubscription: $hasSubscription)
//            }
            
            PlayView()
                .modifier(SystemServices())
                
                
//                .environmentObject(controller)
//                .environmentObject(playlistController)
//                .environmentObject(searches)
//                .environmentObject(themeController)
//                .environmentObject(colorController)
                
            
            /*PlayView(hasSub: $hasSubscription)
                .onReceive(checker.dataPublisher, perform: { hasSub in
                self.hasSubscription = hasSub
            })*/
            
                
            }
        }
    }

struct SystemServices: ViewModifier {
    
    static var controller = MusicController()
    static var playlistController = PlaylistController()
    static var searches = RecentSearches()
    static var themeController = ThemeController()
//    static var colorController = ColorController()
    
    func body(content: Content) -> some View {
        content
            // services
            .environmentObject(Self.controller)
            .environmentObject(Self.playlistController)
            .environmentObject(Self.searches)
            .environmentObject(Self.themeController)
//            .environmentObject(Self.colorController)
    }
}

