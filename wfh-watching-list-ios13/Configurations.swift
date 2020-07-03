//
//  Configurations.swift
//  wfh-movie-todo
//
//  Created by Arie May Wibowo on 30/06/20.
//

import Foundation


struct Configurations {
    static let API_KEY = "3d6b6b6c1ceb0ab7ccfbc54cb997b1a2"
    static let API_BASE = "https://api.themoviedb.org/3/"
    static let API_URL_IMAGE = "https://image.tmdb.org/t/p/w185"
    static let API_NOW_PLAYING_MOVIES = API_BASE + "movie/now_playing?api_key=" + API_KEY
    static let API_TOP_RATE_MOVIES = API_BASE + "movie/top_rated?api_key=" + API_KEY
}
