//
//  ImageController.swift
//  Playlists
//
//  Created by Kaleb Page on 1/2/21.
//

import Foundation
import SwiftUI
import UIKit
import Combine


class ImageLoader: ObservableObject {
    var dataPublisher = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            dataPublisher.send(data)
        }
    }
    
    init(urlString: String) {
        
        DispatchQueue.global(qos: .background).async {
            
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(signedJWT)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
        }
    }
}
    
