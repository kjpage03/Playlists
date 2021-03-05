//
//  PlayViewEditor.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/11/21.
//

import SwiftUI

struct PlayViewEditor: View {
    
    @State var sliderColor = Color.white
    @State var buttonColor = Color.white
    @State var backgroundColor = Color.white
    @Binding var isShowing: Bool
//    @EnvironmentObject var colorController: ColorController
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            DragIndicator()
                Spacer()
            }

            VStack {
                
            HStack {
                Spacer()
            Text("Player Customization")
                .font(.title)
                .bold()
                Spacer()
            }
                Spacer()
            HStack {
                Text("Slider Color:")
                    .padding()
                Spacer()
                ColorPicker("", selection: $sliderColor)
                    .frame(width: 100, height: 100)
                    .scaleEffect(CGSize(width: 3.0, height: 3.0))
                    .padding(.horizontal)
                    .labelsHidden()
            }
            .padding(.top)

            Spacer()
                
            HStack {
                Text("Button Color:")
                    .padding()
                Spacer()
                ColorPicker("", selection: $buttonColor)
                    .frame(width: 100, height: 100)
                    .scaleEffect(CGSize(width: 3.0, height: 3.0))
                    .padding(.horizontal)
                    .labelsHidden()
            }
            Spacer()
//            HStack {
//                Text("Background Color:")
//                    .padding()
//                Spacer()
//                ColorPicker("", selection: $backgroundColor)
//                    .frame(width: 100, height: 100)
//                    .scaleEffect(CGSize(width: 3.0, height: 3.0))
//                    .padding(.horizontal)
//                    .labelsHidden()
//            }
//            Spacer()
                
                VStack() {
                    HStack {
                        Spacer()
                    Button(action: {
                        
//                        colorController.sliderColor = sliderColor
//                        colorController.buttonColor = buttonColor
//                        colorController.backgroundColor = backgroundColor
                        isShowing = false
                        
                    }, label: {
                        Text("Done")
                    })
                        Spacer()
                    }
                }
                Spacer()

            }
            
           
            
        }
        .onAppear(perform: {
//            sliderColor = colorController.sliderColor
//            buttonColor = colorController.buttonColor
//            backgroundColor = colorController.backgroundColor
        })
    }
}

//class ColorController: ObservableObject {
//
//    @Published var sliderColor: Color = Color.red
//    @Published var buttonColor: Color = Color.black
//    @Published var backgroundColor: Color = Color.white
//
//}

//struct PlayViewEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayViewEditor()
//    }
//}
