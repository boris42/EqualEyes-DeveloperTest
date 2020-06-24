//
//  URLImage.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

struct URLImage: View {
    @ObservedObject private var imageLoader: ImageLoader
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
        self.imageLoader = ImageLoader(url)
    }
    
    init(url: String?) {
        let urlStr = url ?? ""
        self.url = URL(string: urlStr)
        self.imageLoader = ImageLoader(self.url)
    }
    
    var image: UIImage? {
        guard let url = url else { return nil }
        if let cachedImage = ImageLoader.imageCache.object(forKey: url as AnyObject) as? UIImage {
            return cachedImage
        }
        return imageLoader.data.flatMap(UIImage.init)
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
