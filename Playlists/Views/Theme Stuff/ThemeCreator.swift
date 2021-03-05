//
//  ThemesView.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/2/21.
//

import SwiftUI

struct ThemeCreator: View {
    
    @State var nameText = ""
    @State var bgColor = Color.white
    @State var acColor = Color.white
    @Binding var isActive: Bool
    @Binding var index: Int
    @Binding var currentTheme: Int
    var title: String
    @EnvironmentObject var themeController: ThemeController
    
    var body: some View {
        
            
        GeometryReader { geometry in
            VStack(spacing: 40) {
                    Spacer()
                    VStack {
                    Text("Name it!")
                TextField("Theme name...", text: $nameText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    }
                
                VStack() {
                    Text("Pick a background color!")
                    ColorPicker("", selection: $bgColor)
                        .frame(width: 120, height: 120, alignment: .center)
                        .scaleEffect(CGSize(width: 4.0, height: 4.0))
                        .labelsHidden()
                }
                
                
                VStack {
                    Text("Pick an accent color!")
                    ColorPicker("", selection: $acColor)
                        .frame(width: 120, height: 120, alignment: .center)
                        .scaleEffect(CGSize(width: 4.0, height: 4.0))
                        .labelsHidden()
                }
                
                Spacer()
                Button(action: {
                    if nameText != "" {
                        themeController.themes.append(Theme(bgColor: CodableColor(uiColor: UIColor(self.bgColor)), acColor: CodableColor(uiColor: UIColor(self.acColor)), name: nameText))
                        index = themeController.themes.count - 1
                        currentTheme = index
                    }
                    isActive = false
                    
                }, label: {
                    Text("Done")
                })
                Spacer()
                }
    //            .padding(.top)
    //            Spacer()
            
            .navigationBarTitle(title, displayMode: .large)
        }
        
    }
}

//struct ThemeCreator_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeCreator()
//    }
//}
