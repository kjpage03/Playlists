//
//  ThemesView.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/2/21.
//

import SwiftUI

struct ThemesView: View {
    
    @State var nameText = ""
    @State var bgColor = Color.white
    @State var acColor = Color.white
    
    var body: some View {
        
        VStack(spacing: 40) {
            Spacer()
            VStack {
                Text("Step 1").bold() + Text(" - Pick a background color!")
                ColorPicker("", selection: $bgColor)
                    .frame(width: 120, height: 120, alignment: .center)
                    .scaleEffect(CGSize(width: 4.0, height: 4.0))
                    .labelsHidden()
            }
            
            
            VStack {
                Text("Step 2").bold() + Text(" - Pick an accent color!")
                ColorPicker("", selection: $acColor)
                    .frame(width: 120, height: 120, alignment: .center)
                    .scaleEffect(CGSize(width: 4.0, height: 4.0))
                    .labelsHidden()
            }
            
            VStack(spacing: 40) {
                Text("Step 3").bold() + Text(" - Name it!")
            TextField("Theme name...", text: $nameText)
                .multilineTextAlignment(.center)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {

            }, label: {
                Text("Done")
            })
            }
            Spacer()
        }

        
        .navigationBarTitle("New Theme", displayMode: .large)
        
    }
}

struct ThemesView_Previews: PreviewProvider {
    static var previews: some View {
        ThemesView()
    }
}
