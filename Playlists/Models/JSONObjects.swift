//
//  JSONObjects.swift
//  Playlists
//
//  Created by Kaleb Page on 12/31/20.
//

import Foundation
import SwiftUI

struct ResponseRoot: Codable {
    var results: Results
}

struct Results: Codable {
    var songs: Songs
}

struct Songs: Codable {
    var href: String
    var next: String
    var data: [Song]
}

