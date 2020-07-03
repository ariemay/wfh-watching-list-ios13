//
//  MovieDetails.swift
//  wfh-watching-list-ios13
//
//  Created by Arie May Wibowo on 02/07/20.
//  Copyright © 2020 Arie May Wibowo. All rights reserved.
//

import SwiftUI

struct MovieDetails: View {
    
    var data: Movie
    
    var body: some View {
        Text(data.title)
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(data: testData)
    }
}
