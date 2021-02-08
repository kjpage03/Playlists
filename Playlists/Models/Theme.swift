//
//  Theme.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/5/21.
//

import Foundation
import UIKit
import SwiftUI

struct Theme: Codable {
    var id = UUID()
    var bgColor: CodableColor
    var acColor: CodableColor
    var name: String
}

struct CodableColor : Codable {
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0

    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

class ThemeController: ObservableObject {
        
    @Published var themes: [Theme] = [] {
        didSet {
            //write to disk
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            let archiveURL = documentsDirectory.appendingPathComponent("themes").appendingPathExtension("plist")

            let propertyListEncoder = PropertyListEncoder()

            let encodedItems = try? propertyListEncoder.encode(themes)

            try? encodedItems?.write(to: archiveURL, options: .noFileProtection)
        }
    }
    
    init() {
        //take data from disk
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let archiveURL = documentsDirectory.appendingPathComponent("themes").appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        
        if let retrievedData = try? Data(contentsOf: archiveURL) {
            if let decodedItems = try? propertyListDecoder.decode([Theme].self, from: retrievedData) {

                    if decodedItems.count == 0 {
                        self.themes.append(Theme(bgColor: CodableColor(uiColor: UIColor(.white)), acColor: CodableColor(uiColor: UIColor(.black)), name: "Default"))
                    }
                                    
            }
        }
        
        if let retrievedData = try? Data(contentsOf: archiveURL) {
            if let decodedItems = try? propertyListDecoder.decode([Theme].self, from: retrievedData) {
                self.themes = decodedItems
            } else {
                self.themes = []
            }
        } else {
            self.themes = []
        }
    }
    
    
}
