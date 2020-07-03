//
//  Movies.swift
//  wfh-watching-list-ios13
//
//  Created by Arie May Wibowo on 02/07/20.
//  Copyright © 2020 Arie May Wibowo. All rights reserved.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title, poster_path, overview: String
}

struct MovieRequest: Decodable {
    let results: [Movie]
}


let testData = Movie(id: 1, title: "Avenger", poster_path: "test", overview: "test")

