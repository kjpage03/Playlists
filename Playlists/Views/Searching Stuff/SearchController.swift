//
//  SearchController.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/27/21.
//

import Foundation
import SwiftUI

struct SearchController {
    
    var isNextPage: Bool = false
    var limit: Int?
    
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
            URLQueryItem(name: isNextPage ? "offset" : "limit", value: limit == nil ? "25" : String(limit!)),
            URLQueryItem(name: "types", value: "songs"),
        ]

        let url = components.url!

        var request = URLRequest(url: url)
        request.setValue("Bearer \(signedJWT)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()

            if let data = data {

                print(data)
                
                if let response = try? jsonDecoder.decode(ResponseRoot.self, from: data) {

                    completionHandler(response.results.songs.data)
                }

            }
        }
        task.resume()
    }
    
    
}
