//
//  Next.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/8/21.
//

import SwiftUI

struct Next: View {
    var body: some View {
        Text("More")
            .frame(width: 50, height: 50, alignment: .center)
            .foregroundColor(.blue)
            .overlay(Circle()
                        //.stroke(Color.black, lineWidth: 0.5)
                        .scaleEffect(CGSize(width: 1, height: 1))
                        .opacity(0.05))
            .shadow(radius: 10)
    }
}

struct Next_Previews: PreviewProvider {
    static var previews: some View {
        Next()
    }
}
