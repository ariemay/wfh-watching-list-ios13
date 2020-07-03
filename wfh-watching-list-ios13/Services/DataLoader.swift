//
//  DataLoader.swift
//  wfh-watching-list-ios13
//
//  Created by Arie May Wibowo on 02/07/20.
//  Copyright © 2020 Arie May Wibowo. All rights reserved.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    @Published var dataIsValid = false
    var data:Data?

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataIsValid = true
                self.data = data
            }
        }
        task.resume()
    }
}


struct ImageViewWidget: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(urlString: url)
    }
    
    func imageFromData(_ data:Data) -> UIImage {        return UIImage(data: data) ?? UIImage()
    }

    var body: some View {
        VStack {
            Image(uiImage: (imageLoader.dataIsValid ? imageFromData(imageLoader.data!) : UIImage(named: "Avenger"))!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .cornerRadius(20)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 5)
                .shadow(radius: 5)
        }
    }
}

