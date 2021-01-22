//
//  ContentView.swift
//  Playlists
//
//  Created by Kaleb Page on 12/17/20.
//

import SwiftUI
import StoreKit
import MediaPlayer
import Combine


class SubscriptionChecker: ObservableObject {
    
    var dataPublisher = PassthroughSubject<Bool, Never>()
    var hasSub = Bool() {
        didSet {
            dataPublisher.send(hasSub)
        }
    }
    
    init() {
        
        let controller = SKCloudServiceController()

            controller.requestCapabilities { capabilities, error in
                if capabilities.contains(.musicCatalogPlayback) {
                    // User has Apple Music account
                    DispatchQueue.main.async {
                        self.hasSub = true
                    }
    
                }
                else if capabilities.contains(.musicCatalogSubscriptionEligible) {
                    
                    // User can sign up to Apple Music
                    DispatchQueue.main.async {
                        self.hasSub = false
                    }
                    
                }
            }
    }
    
    /*static func checkSubscription(completion: @escaping (Bool) -> Void) {
        

    }*/

}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}
