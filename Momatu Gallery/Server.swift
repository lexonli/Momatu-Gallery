//
//  Server.swift
//  Momatu Gallery
//
//  Created by Lexon on 1/12/2020.
//

import Foundation
import SwiftyJSON

class Server {
    
    static let shared = Server()
    
    /// Fetches images from the Picsum image list API
    /// - Parameters:
    ///   - page: Current page in the grid
    ///   - completion: A completion handler that takes takes an array of images if successful, nil if failed
    func fetchImages(page: Int, completion: @escaping ([Image]?)->()) {
        URLSession.shared.get(with: "\(PicsumConstants.photoListUrl)?page=\(page)") { (result) in
            switch (result) {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let images = try decoder.decode([Image].self, from: data)
                        completion(images)
                    } catch {
                        print(error)
                        completion(nil)
                    }
                case .failure(let error):
                    print(error)
                    completion(nil)
            }
        }.resume()
    }
}
