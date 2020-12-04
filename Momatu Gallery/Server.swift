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
    
    let data = Data("""
    [{"id":"0","author":"Alejandro Escamilla","width":5616,"height":3744,"url":"https://unsplash.com/photos/yC-Yzbqy7PY","download_url":"https://picsum.photos/id/0/5616/3744"},{"id":"1","author":"Alejandro Escamilla","width":5616,"height":3744,"url":"https://unsplash.com/photos/LNRyGwIJr5c","download_url":"https://picsum.photos/id/1/5616/3744"},{"id":"10","author":"Paul Jarvis","width":2500,"height":1667,"url":"https://unsplash.com/photos/6J--NXulQCs","download_url":"https://picsum.photos/id/10/2500/1667"},{"id":"100","author":"Tina Rataj","width":2500,"height":1656,"url":"https://unsplash.com/photos/pwaaqfoMibI","download_url":"https://picsum.photos/id/100/2500/1656"},{"id":"1000","author":"Lukas Budimaier","width":5626,"height":3635,"url":"https://unsplash.com/photos/6cY-FvMlmkQ","download_url":"https://picsum.photos/id/1000/5626/3635"},{"id":"1001","author":"Danielle MacInnes","width":5616,"height":3744,"url":"https://unsplash.com/photos/1DkWWN1dr-s","download_url":"https://picsum.photos/id/1001/5616/3744"},{"id":"1002","author":"NASA","width":4312,"height":2868,"url":"https://unsplash.com/photos/6-jTZysYY_U","download_url":"https://picsum.photos/id/1002/4312/2868"},{"id":"1003","author":"E+N Photographies","width":1181,"height":1772,"url":"https://unsplash.com/photos/GYumuBnTqKc","download_url":"https://picsum.photos/id/1003/1181/1772"},{"id":"1004","author":"Greg Rakozy","width":5616,"height":3744,"url":"https://unsplash.com/photos/SSxIGsySh8o","download_url":"https://picsum.photos/id/1004/5616/3744"},{"id":"1005","author":"Matthew Wiebe","width":5760,"height":3840,"url":"https://unsplash.com/photos/tBtuxtLvAZs","download_url":"https://picsum.photos/id/1005/5760/3840"},{"id":"1006","author":"Vladimir Kudinov","width":3000,"height":2000,"url":"https://unsplash.com/photos/-wWRHIUklxM","download_url":"https://picsum.photos/id/1006/3000/2000"},{"id":"1008","author":"Benjamin Combs","width":5616,"height":3744,"url":"https://unsplash.com/photos/5L4XAgMSno0","download_url":"https://picsum.photos/id/1008/5616/3744"},{"id":"1009","author":"Christopher Campbell","width":5000,"height":7502,"url":"https://unsplash.com/photos/CMWRIzyMKZk","download_url":"https://picsum.photos/id/1009/5000/7502"},{"id":"101","author":"Christian Bardenhorst","width":2621,"height":1747,"url":"https://unsplash.com/photos/8lMhzUjD1Wk","download_url":"https://picsum.photos/id/101/2621/1747"},{"id":"1010","author":"Samantha Sophia","width":5184,"height":3456,"url":"https://unsplash.com/photos/NaWKMlp3tVs","download_url":"https://picsum.photos/id/1010/5184/3456"}]
    """.utf8)
}
