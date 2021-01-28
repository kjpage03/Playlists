//
//  SearchBar.swift
//  Playlists
//
//  Created by Kaleb Page on 12/17/20.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var songs: [Song]?
    @Binding var listShowing: Bool
    //@Binding var showMore: Bool
    @EnvironmentObject var searches: RecentSearches
    @State var myResponse: Results?
    
    func nextButtonClicked() {
        guard let results = myResponse else { return }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host   = "api.music.apple.com"
        components.path   = results.songs.next
        
        let url = components.url!
        print("url")
        var request = URLRequest(url: url)
        request.setValue("Bearer \(signedJWT)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data {
                                
                if let response = try? jsonDecoder.decode(ResponseRoot.self, from: data) {
                    
                    songs = response.results.songs.data
                    myResponse = response.results
                }
                
            }
        }
        task.resume()
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> some UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
                
        var parent: SearchBar

        init(_ parent: SearchBar) {
            self.parent = parent
        }
        
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                        
            guard let text = searchBar.text else { return }
            
            let searchController = SearchController()
            searchController.search(term: text) { (songs) in
                
                DispatchQueue.main.async {
                    withAnimation(.easeIn(duration: 0.5)) {
                        self.parent.songs = songs
                        self.parent.listShowing = true
                        self.parent.searches.items.append(Search(name: text))
                        searchBar.endEditing(true)
                    }
                    
                }
                //self.parent.showMore = true
            }
            
        }
        
    }
    
}
