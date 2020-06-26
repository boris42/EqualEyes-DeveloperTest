//
//  ImageLoader.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import UIKit
import Combine

final class ImageLoader: ObservableObject {
    static let imageCache = NSCache<NSURL, UIImage>()

    @Published var image: UIImage?

    var url: URL? {
        didSet { loadImage() }
    }

    private var dataLoader: AnyCancellable?

    init() {}
        
    init(_ url: URL?) {
        self.url = url
    }

    deinit { dataLoader?.cancel() }

    func loadImage() {
        dataLoader?.cancel()
        guard let url = url else { return }
        if let cachedImage = ImageLoader.imageCache.object(forKey: url as NSURL) {
            self.image = cachedImage
        } else {
            dataLoader =  URLSession.shared.dataTaskPublisher(for: url)
                .compactMap { UIImage(data: $0.data) }
                .assertNoFailure()
                .receive(on: RunLoop.main)
                .sink { image in
                    self.image = image
                    Self.imageCache.setObject(image, forKey: url as NSURL)
            }
        }
    }
}
