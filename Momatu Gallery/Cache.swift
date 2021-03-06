//
//  Cache.swift
//  Momatu Gallery
//
//  Created by Lexon on 2/12/2020.
//

import UIKit

/// Handles an in memory cache of image urls to the respective UIImage
class Cache {
    
    static let shared = Cache()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(withUrl url: String, completion: @escaping (UIImage?) -> ()) {
        if let image = imageCache.object(forKey: NSString(string: url)) {
            completion(image)
        } else {
            fetchImage(withUrl: url, completion: completion)
        }
    }
    
    private func fetchImage(withUrl url: String, completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.get(with: url) { (result) in
            switch (result) {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completion(nil)
                        return
                    }
                    self.imageCache.setObject(image, forKey: NSString(string: url))
                    completion(image)
                case .failure(let error):
                    print(error)
                    completion(nil)
            }
        }.resume()
    }
}
