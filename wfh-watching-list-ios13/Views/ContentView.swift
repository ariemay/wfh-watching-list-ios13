//
//  ContentView.swift
//  wfh-watching-list-ios13
//
//  Created by Arie May Wibowo on 02/07/20.
//  Copyright © 2020 Arie May Wibowo. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ContentView: View {
    
    @ObservedObject var networkManager: NetworkManager = NetworkManager()
    
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.titleTextAttributes = [
            .font : UIFont(name: "HelveticaNeue-Thin", size: 20)!]
        coloredAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font : UIFont(name:"Papyrus", size: 40)!]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Top Movie List")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(self.networkManager.topMovies) { res in
                                VStack(alignment: .leading, spacing: 0) {
                                    MovieList(data: res)
                                }
                            }
                        }
                        .frame(height: 300)
                    }
                    .onAppear {
                        self.networkManager.loadTopMovies()
                    }
                    Text("Now Playing Movie")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(networkManager.nowPlayingMovies) {
                                res in
                                VStack {
                                    MovieList(data: res)
                                }
                            }
                        }
                        .frame(height: 300)
                        .onAppear {
                            self.networkManager.loadNowPlayingMovies()
                        }
                    }
                    Spacer()
                }
                .navigationBarTitle("WFH Watching List")
                .padding()
            }
        }
    }
    
}


struct MovieList: View {
    @State var data: Movie
    
    var body: some View {
        NavigationLink(destination: MovieDetails(data: data)) {
            ImageViewWidget(url: Configurations.API_URL_IMAGE + data.poster_path)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
