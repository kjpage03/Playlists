//
//  SearchButton.swift
//  Playlists
//
//  Created by Kaleb Page on 12/18/20.
//

import SwiftUI

struct SearchButton: View {
    
    
    var body: some View {
        
        Image("Search")
            .scaleEffect(CGSize(width: 0.25, height: 0.25))
            .frame(width: 100, height: 100, alignment: .center)
    }
    
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        
            SearchButton()
    }
}
