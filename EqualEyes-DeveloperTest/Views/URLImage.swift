//
//  URLImage.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

struct URLImage: View {
    @ObservedObject private var imageLoader: ImageLoader = ImageLoader()
    
    init(url: URL?) {
        imageLoader.url = url
    }
    
    init(url: String?) {
        if let urlStr = url {
            imageLoader.url = URL(string: urlStr)
        }
    }
    
    var image: UIImage? {
        imageLoader.image
    }
    
    var body: Image {
        Image(uiImage: image ?? UIImage())
            .resizable()
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "https://picsum.photos/500")
            .aspectRatio(contentMode: .fit)
    }
}
