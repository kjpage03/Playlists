//
//  RecentSearchesView.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 1/27/21.
//

import SwiftUI

struct RecentSearchesView: View {
    
    @EnvironmentObject var searches: RecentSearches
    @Binding var songs: [Song]?
    @Binding var listShowing: Bool
    var searchController = SearchController()
    var exampleSearches = ["Weezer", "Asia", "Led Zeppelin", "REO Speedwagon"]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack {
                Text("Recents")
                    .bold()
                    .font(.title)
                Spacer()
                Button(action: {
                    withAnimation(.easeOut(duration: 1)) {
                        searches.items.removeAll()
                    }
                }, label: {
                    Text("Clear")
                })
            }
            .padding(.bottom, -5)
            
            
            List(searches.items.reversed()) { item in
                
                Button(action: {
                    DispatchQueue.global(qos: .background).async {
                        searchController.search(term: item.name) { (songs) in
                            withAnimation(.easeIn(duration: 0.5)) {
                            self.songs = songs
                            self.listShowing = true
                            }
                        }
                    }
                        
                    
                    
                }, label: {
                    Text(item.name)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                })
            }
            
        }
        .padding(.horizontal)
        //        .background(Color.gray.opacity(0.4))
        
    }
}

//struct RecentSearchesView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentSearchesView()
//    }
//}


