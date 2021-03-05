//
//  ThemeEditor.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/10/21.
//

import SwiftUI

struct ThemeEditor: View {
    
    var theme: Theme
    @State var nameText = ""
    @State var bgColor = Color.white
    @State var acColor = Color.white
    @Binding var isActive: Bool
    @Binding var index: Int
    @Binding var currentTheme: Int
    @State var reqsNotMet: Bool = false
    var title: String
    @EnvironmentObject var themeController: ThemeController
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack(spacing: 40) {
                    Spacer()
                
                if reqsNotMet == true {
                    Text("Give it a name.")
                        .foregroundColor(.red)
                }
                
                    VStack {
                    Text("Name it!")
                        .bold()
                TextField("Theme name...", text: $nameText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    }
                
                VStack() {
                    Text("Pick a background color!")
                        .bold()
                    ColorPicker("", selection: $bgColor)
                        .frame(width: 120, height: 120, alignment: .center)
                        .scaleEffect(CGSize(width: 4.0, height: 4.0))
                        .labelsHidden()
                }
                
                
                VStack {
                    Text("Pick an accent color!")
                        .bold()
                    ColorPicker("", selection: $acColor)
                        .frame(width: 120, height: 120, alignment: .center)
                        .scaleEffect(CGSize(width: 4.0, height: 4.0))
                        .labelsHidden()
                }
                
                VStack {
                Spacer()
                Button(action: {
                    if nameText != "" {
                        for (index, item) in themeController.themes.enumerated() {
                            if item.id == theme.id {

                                themeController.themes[index].name = nameText
                                themeController.themes[index].bgColor = CodableColor(uiColor: UIColor(self.bgColor))
                                themeController.themes[index].acColor = CodableColor(uiColor: UIColor(self.acColor))
                                self.index = index
                            }
                        }
//                        index = themeController.themes.count - 1
                        currentTheme = index
                        isActive = false
                        
                    } else {
                        //show something that tells user to meet all requirements
                        reqsNotMet = true
                    }
                    

                }, label: {
                    Text("Done")
                })
                Spacer()
                Button(action: {
                    index = themeController.themes.count - 2
                    currentTheme = index
                    for (index, item) in themeController.themes.enumerated() {
                        if item.id == theme.id {
                            themeController.themes.remove(at: index)
                        }
                    }
                    
                    isActive = false
                }, label: {
                    Text("Delete Theme")
                        .foregroundColor(.red)
                })
                Spacer()
            }
            }
            
            .navigationBarTitle(title, displayMode: .large)
        }
        .onAppear(perform: {
            nameText = theme.name
            bgColor = Color(theme.bgColor.uiColor)
            acColor = Color(theme.acColor.uiColor)
        })
    }
}

//struct ThemeEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditor()
//    }
//}
