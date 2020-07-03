//
//  NetworkManager.swift
//  wfh-movie-todo
//
//  Created by Arie May Wibowo on 01/07/20.
//

import Foundation
import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published public var topMovies = [Movie]()
    @Published public var nowPlayingMovies = [Movie]()
    
    public func loadTopMovies() {
        let json = Configurations.API_TOP_RATE_MOVIES
        
        guard let url = URL(string: json) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            let movieRequest = try! JSONDecoder().decode(MovieRequest.self, from: data)
            
            DispatchQueue.main.async {
                self.topMovies = movieRequest.results
            }
        }.resume()
    }
    
    public func loadNowPlayingMovies() {
        let json = Configurations.API_NOW_PLAYING_MOVIES
        
        guard let url = URL(string: json) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            let movieRequest = try! JSONDecoder().decode(MovieRequest.self, from: data)
            
            DispatchQueue.main.async {
                self.nowPlayingMovies = movieRequest.results
            }
        }.resume()
    }
}
