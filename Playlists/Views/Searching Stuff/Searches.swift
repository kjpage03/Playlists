//
//  RecentSearches.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/27/21.
//

import Foundation

struct Search: Codable, Identifiable {
    var id = UUID()
    var name: String
}

class RecentSearches: ObservableObject {
    
    @Published var items: [Search] {
        didSet {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            let archiveURL = documentsDirectory.appendingPathComponent("recentSearches").appendingPathExtension("plist")

            let propertyListEncoder = PropertyListEncoder()

            let encodedItems = try? propertyListEncoder.encode(items)
            
            try? encodedItems?.write(to: archiveURL, options: .noFileProtection)
        }
    }
    
    init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let archiveURL = documentsDirectory.appendingPathComponent("recentSearches").appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        
        if let retrievedData = try? Data(contentsOf: archiveURL) {
            if let decodedItems = try? propertyListDecoder.decode([Search].self, from: retrievedData) {
                self.items = decodedItems
            } else {
                self.items = []
            }
        } else {
            self.items = []
        }
    }
}
