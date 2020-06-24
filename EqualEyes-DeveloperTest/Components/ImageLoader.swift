//
//  ImageLoader.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import UIKit

final class ImageLoader: ObservableObject {
    static let imageCache = NSCache<AnyObject, AnyObject>()

    private var task: URLSessionDataTask?
    @Published var data: Data?

    init(_ url: URL?) {
        if let url = url {
            task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let imageToCache = UIImage(data: data) {
                    Self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                DispatchQueue.main.async { self.data = data }
            }
            task?.resume()
        }
    }

    deinit {
        task?.cancel()
    }
}
