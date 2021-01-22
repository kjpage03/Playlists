//
//  SearchBar.swift
//  Playlists
//
//  Created by Kaleb Page on 12/17/20.
//

import SwiftUI


struct SearchBar: UIViewRepresentable {
    
    @Binding var songs: [Song]?
    //@Binding var showMore: Bool

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
            
            let searchTerm  = text.lowercased()
            let countryCode = "us"

            var components = URLComponents()
            components.scheme = "https"
            components.host   = "api.music.apple.com"
            components.path   = "/v1/catalog/\(countryCode)/search"
                    
            components.queryItems = [
                URLQueryItem(name: "term", value: searchTerm),
                URLQueryItem(name: "limit", value: "25"),
                URLQueryItem(name: "types", value: "songs"),
            ]

            let url = components.url!
            
            var request = URLRequest(url: url)
            request.setValue("Bearer \(signedJWT)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                
                if let data = data {
                    
                    //print(data)
//                    let string = String(data: data, encoding: .utf8)
//                    print(string ?? "")
                    
                    if let response = try? jsonDecoder.decode(ResponseRoot.self, from: data) {
                        //self.parent.songs = response.results.songs.data
                        /*print(response.results.songs.href)
                        print(response.results.songs.next)
                        print(response.results.songs.data.first?.type)
                        print(response.results.songs.data.first?.id)
                        print(response.results.songs.data.first?.attributes)*/
                        self.parent.songs = response.results.songs.data
                    }
                    
                }
            }
            task.resume()
            searchBar.endEditing(true)
            //self.parent.showMore = true
        }
        
    }
    
}
