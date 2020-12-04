//
//  Cache.swift
//  Momatu Gallery
//
//  Created by Lexon on 2/12/2020.
//

import UIKit

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
    
//    func loadImageTask(withUrl url: String, completion: @escaping (String, UIImage?) -> ()) -> URLSessionTask? {
//        if let image = imageCache.object(forKey: NSString(string: url)) {
//            completion(url, image)
//            return nil
//        } else {
//            return getImageTask(withUrl: url, completion: completion)
//        }
//    }
//
//    private func getImageTask(withUrl url: String, completion: @escaping (String, UIImage?) -> ()) -> URLSessionTask {
//        URLSession.shared.get(with: url) { (result) in
//            switch (result) {
//                case .success(let data):
//                    guard let image = UIImage(data: data) else {
//                        completion(url, nil)
//                        return
//                    }
//                    self.imageCache.setObject(image, forKey: NSString(string: url))
//                    completion(url, image)
//                case .failure(let error):
//                    print(error)
//                    completion(url, nil)
//            }
//        }
//    }
}
