//
//  SearchController.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/27/21.
//

import Foundation
import SwiftUI

struct SearchController {
    
    
    func search(term: String, completionHandler: @escaping ([Song]) -> Void) {
        let searchTerm = term.lowercased()
//        self.parent.searches.items.append(Search(name: searchTerm))
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
//                    self.parent.songs = response.results.songs.data
//                    return response.results.songs.data
                    completionHandler(response.results.songs.data)
                }
                
            }
        }
        task.resume()
    }
    
    
}
