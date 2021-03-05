//
//  Song.swift
//  Playlists
//
//  Created by Kaleb Page on 12/17/20.
//

import Foundation
import UIKit
import SwiftUI
import MediaPlayer

struct Song: Codable, Identifiable {
    
    var id: String
    var type: String
    var attributes: Attributes
    var photo: Data?
    var uniqueID = UUID()
    
    private enum CodingKeys: String, CodingKey {
            case id
            case type
            case attributes
            case photo
//            case uniqueID
        }
    
    static func fetchPhotoInfo(completion: @escaping (UIImage) -> Void, url: String) {
    
        guard let newURL = URL(string: url) else {
            completion(UIImage(named: "gray-square")!)
            return
        }
        
        let task = URLSession.shared.dataTask(with: newURL) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                
                completion(image)
            }
        }
        task.resume()
    }
    
}

struct Attributes: Codable {
    
    var albumName: String
    var artistName: String
    var artwork: Artwork
    var name: String
    
    //Other properties I may need in the future
    
//    var discNumber: Int
//    var genreNames: [String]
//    var isrc: String
    
//    var previews: [Preview]
//    var releaseDate: String
//    var trackNumber: Int
    var contentRating: String?
    var url: String?
    var durationInMillis: Int
}

struct Artwork: Codable {
    var height: Int
    var width: Int
    var url: String
}

struct Preview: Codable {
    var url: String
}
