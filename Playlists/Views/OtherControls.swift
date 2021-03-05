//
//  OtherControls.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/10/21.
//

import SwiftUI

struct OtherControls: View {
    @State var queuePresented: Bool = false
    @State var editorPresented: Bool = false
    @State private var backgroundColor = Color.white
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    queuePresented = true
                }, label: {
                    Image(systemName: "list.number")
                        .scaleEffect(CGSize(width: 1.6, height: 1.6))
                        
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                        .opacity(0.7)
                })
                .sheet(isPresented: $queuePresented, content: {
                    QueueView()
                })
                Spacer()
                Button(action: {
                    //present customization options
                    editorPresented = true
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .scaleEffect(CGSize(width: 1.6, height: 1.6))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                        .opacity(0.7)
                })
//                .actionSheet(isPresented: $editorPresented) {
//                    ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
//                        .default(Text("Red")) { self.backgroundColor = .red },
//                        .default(Text("Green")) { self.backgroundColor = .green },
//                        .default(Text("Blue")) { self.backgroundColor = .blue },
//                        .cancel()
//                    ])
//                }
                .sheet(isPresented: $editorPresented, content: {
                    PlayViewEditor(isShowing: $editorPresented)
                })
                Spacer()
            }
//            QueueButton()
            Spacer()
        }
    }
}

struct OtherControls_Previews: PreviewProvider {
    static var previews: some View {
        OtherControls()
    }
}
