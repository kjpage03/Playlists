//
//  DragIndicator.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/10/21.
//

import SwiftUI

struct DragIndicator: View {
    var body: some View {
        Image(systemName: "rectangle.fill")
            .scaleEffect(CGSize(width: 2.0, height: 0.25))
            .foregroundColor(.gray)
            .opacity(0.6)
            .padding()
    }
}

struct DragIndicator_Previews: PreviewProvider {
    static var previews: some View {
        DragIndicator()
    }
}
