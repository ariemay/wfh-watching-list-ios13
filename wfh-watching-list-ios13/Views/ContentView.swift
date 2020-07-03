//
//  ContentView.swift
//  wfh-watching-list-ios13
//
//  Created by Arie May Wibowo on 02/07/20.
//  Copyright © 2020 Arie May Wibowo. All rights reserved.
//

import SwiftUI
import Combine
import UserNotifications

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
        
        scheduleNotification()
        
    }
    
    var body: some View {
        TabView {
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
                }
                .navigationBarTitle("WFH Watching List")
                .padding()
            }
            .tabItem{
                Image(systemName: "house")
                Text("Home")
            }
            NavigationView {
                Text("Test")
                .navigationBarTitle("Favorite")
            }
            .tabItem{
                Image(systemName: "tv")
                Text("Favorite")
            }
        }
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted, error) in
            if granted {
                print("You have been granted")
            } else {
                print("Not granted")
            }
        })

        let content = UNMutableNotificationContent()
        content.title = "Have you watching a movie today?"
        content.body = "Go get a movie!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "ariemay"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
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
