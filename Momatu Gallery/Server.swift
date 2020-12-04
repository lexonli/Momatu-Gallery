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
    
    private let listUrl = "https://picsum.photos/v2/list"
    
    func fetchImages(page: Int, completion: @escaping ([Image]?)->()) {
        URLSession.shared.get(with: "\(listUrl)?page=\(page)") { (result) in
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
