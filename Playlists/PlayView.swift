//
//  PlayView.swift
//  Playlists
//
//  Created by Kaleb Page on 1/5/21.
//

import SwiftUI
import StoreKit
import MediaPlayer
import Combine

struct PlayView: View {
    
    //MARK: TODO: Research importing playlists
    //MARK: TODO: Searching albums?
    //MARK: TODO: More button on search view
    //MARK: TODO: Touch up the slider
    //MARK: TODO: Playlist create/edit
    //Other - Constraints
    
    @State var currentTime: TimeInterval = 0
    @State var timeElapsed: String = "0:00"
    @State var timeRemaining: String = "0:00"
    @State var isPlaying: Bool = false
    @State var didSkip: Bool = false
    @State var didBack: Bool = false
    @State var showQueue: Bool = false
    @State var queuePresented: Bool = false
        
    @Environment(\.colorScheme) var colorScheme
    
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    @EnvironmentObject var controller: MusicController
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func updateElapsedTime() {
        self.currentTime = controller.musicPlayer.currentPlaybackTime
        
        let elapsedTime = Int(currentTime)
        
        let (_, m, s) = secondsToHoursMinutesSeconds(seconds: elapsedTime)
        
        if s < 10 {
            let finalTimeLeft = "\(m):0\(s)"
            timeElapsed = finalTimeLeft
        } else {
            let finalTimeLeft = "\(m):\(s)"
            timeElapsed = finalTimeLeft
        }
    }
    
    func updateRemainingTime() {
        let timeLeft = controller.currentSong.attributes.durationInMillis/1000 - Int(currentTime)
        
        let (_, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: timeLeft)
        
        if seconds < 10 {
            let finalTimeLeft = "\(minutes):0\(seconds)"
            timeRemaining = finalTimeLeft
        } else {
            let finalTimeLeft = "\(minutes):\(seconds)"
            timeRemaining = finalTimeLeft
        }
        
        
    }
    
    var body: some View {
        
        //MARK: Custom Bindings
        
        let isPaused = Binding<Bool>(
            get: {
                self.isPlaying
            }, set: {
                self.isPlaying = $0
                
                if self.isPlaying {
                    self.controller.musicPlayer.stop()
                } else {
                    self.controller.musicPlayer.play()
                }
            })
        
        let skipped = Binding<Bool> { () -> Bool in
            self.didSkip
        } set: {
            self.didSkip = $0
            if self.didSkip {
                
                //                controller.musicPlayer.currentPlaybackTime = TimeInterval(controller.currentSong.attributes.durationInMillis/1000)
                
                controller.musicPlayer.skipToNextItem()
                self.didSkip = false
            }
        }
        
        let didGoBack = Binding<Bool> { () -> Bool in
            self.didBack
        } set: {
            self.didBack = $0
            if self.didBack {
                if Int(currentTime) < 3 {
                    controller.musicPlayer.skipToPreviousItem()
                    self.didBack = false
                } else {
                    controller.musicPlayer.skipToBeginning()
                    self.didBack = false
                }
                
            }
        }
        
        let time = Binding<Double>(
            get: {
                self.currentTime
            },
            set: {
                self.currentTime = $0
//                controller.musicPlayer.stop()
                controller.musicPlayer.currentPlaybackTime = self.currentTime
                controller.musicPlayer.prepareToPlay()
                if !self.isPlaying {
                    controller.musicPlayer.play()
                }
            }
        )
        
        //MARK: View
        
        NavigationView() {
            
            VStack(alignment: .center, spacing: 20) {
//                Spacer()
                ImageView(withURL: controller.currentSong.attributes.artwork.url, height: controller.currentSong.attributes.artwork.height, width: controller.currentSong.attributes.artwork.width, frameHeight: 290, frameWidth: 290)
                    //.clipShape(Circle())
                    .shadow(radius: 10)
                    .offset(x: 0, y: -5)
                
                Slider(value: time, in: 0...Double(controller.currentSong.attributes.durationInMillis/1000), step: 1)
                    .accentColor(.red)
                    .padding(.leading)
                    .padding(.trailing)
                
                HStack {
                    Text("\(timeElapsed)")
                        .fontWeight(.light)
                        .padding()
                        .onReceive(timer, perform: { _ in
                                                        
                            updateElapsedTime()
                            
                            updateRemainingTime()
                            
                        })
                    
                    Spacer()
                    Text("\(timeRemaining)")
                        .fontWeight(.light)
                        .padding()
                    
                }
                .offset(x: 0, y: -30)
                
                VStack(alignment: .center, spacing: 5) {
                    VStack(alignment: .center, spacing: 5) {
                        if let rating = controller.currentSong.attributes.contentRating?.capitalized {
                                Text(controller.currentSong.attributes.name).bold() + Text(" (\(rating))")
                        } else {
                            Text(controller.currentSong.attributes.name)
                                .bold()
                                .multilineTextAlignment(.center)
                        }
                        
                        Text(controller.currentSong.attributes.artistName)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                    }
                    
                    PlayControl(isPaused: isPaused, didSkip: skipped, didGoBack: didGoBack)
                        //.offset(x: 0, y: -50)
                        .offset(x: 0, y: 0)

                }
                .offset(x: 0, y: -60)
                
                //                Button(action: {
                //                showQueue = true
                //                }, label: {
                //                    Image(systemName: "music.note.list")
                //                        .foregroundColor(.black)
                //                        .scaleEffect(CGSize(width: 2.0, height: 2.0))
                //                })
                
//                VStack {
//                HStack(spacing: 150) {
//
//                    Button(action: {
//
//                    }, label: {
//                        Image(systemName: "paintbrush.fill")
//                            .foregroundColor(.black)
//                    })
//                    .scaleEffect(CGSize(width: 2.0, height: 2.0))
//
//                Button(action: {
//                    queuePresented = true
//                }, label: {
//                    Image(systemName: "list.number")
//                        .foregroundColor(.black)
//                })
//                .scaleEffect(CGSize(width: 2.0, height: 2.0))
//                .sheet(isPresented: $queuePresented, content: {
//                    QueueView()
//                })
//                }

//                }

                .navigationBarItems(
                    
                    leading:
                        NavigationLink(destination: SearchView(songs: nil, backButtonHidden: false)) {
                            Image("Search")
                                .renderingMode(.template)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .scaleEffect(CGSize(width: 0.2, height: 0.2))
                                .frame(width: 50, height: 50, alignment: .center)},
                    
                    trailing:
                        
                        NavigationLink(destination: PlaylistsView()) {
                            Image("List")
                                .renderingMode(.template)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .scaleEffect(CGSize(width: 0.09, height: 0.09))
                                .frame(width: 50, height: 50, alignment: .center)
                        })
                
                
            }
            .offset(x: 0, y: -55)
            //increases, down; decreases, up
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct PlayView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlayView()
    }
}





