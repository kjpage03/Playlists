//
//  SearchBar.swift
//  Playlists
//
//  Created by Kaleb Page on 12/17/20.
//

import SwiftUI


struct TableView: UIViewControllerRepresentable {
    
    var songs: [Song]
    
    func makeUIViewController(context: Context) -> SearchViewController {
        let searchViewController = SearchViewController()
        searchViewController.songs = songs
        return searchViewController
    }
    
    func updateUIViewController(_ uiViewController: SearchViewController, context: Context) {
        
    }
    
}
