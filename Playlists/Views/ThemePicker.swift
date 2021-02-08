//
//  ThemePicker.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/5/21.
//

import SwiftUI

struct ThemePicker: View {
 
    @EnvironmentObject var themeController: ThemeController
    @State var index: Int = 0
    @State var isActive = false
    @Binding var currentTheme: Int
    
//    init( currentTheme: Binding<Int>) {
//        _index = State(initialValue: startingIndex)
//        self._currentTheme = currentTheme
//    }
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            //            Text("Theme")
            //                .font(.headline)
            Text("\(index+1) of \(themeController.themes.count)")
                .font(.subheadline)
            
            VStack {
                Text(themeController.themes[index].name)
                    .font(.system(size: 10))
                HStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 25, height: 50)
                        .foregroundColor(Color(themeController.themes[index].bgColor.uiColor))
                    Rectangle()
                        .frame(width: 25, height: 50)
                        .foregroundColor(Color(themeController.themes[index].acColor.uiColor))
                }
                .clipShape(Circle())
                .shadow(radius: 5)
            }
            .gesture(
                DragGesture()
                    .onEnded({ (value) in
                        if value.translation.width < 0 {
                            // left
                            if index != themeController.themes.count-1 {
                                withAnimation(.spring()) {
                                    index += 1
                                    currentTheme = index
                                }
                            }
                        }
                        
                        if value.translation.width > 0 {
                            // right
                            
                            if index != 0 {
                                withAnimation(.spring()) {
                                    index -= 1
                                    currentTheme = index
                                }
                            }
                        }
                    })
            )
            
            NavigationLink(destination: ThemeCreator(isActive: $isActive), isActive: $isActive) {

                Button(action: {
                    isActive = true
                }, label: {
                    Image(systemName: "plus")
                        .scaleEffect(CGSize(width: 1.3, height: 1.3))
                        .padding(.top)
                })
            }
            
        }
        
        
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
//        ThemePicker()
        Text("")
    }
}


