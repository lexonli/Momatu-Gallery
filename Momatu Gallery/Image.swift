//
//  Image.swift
//  Momatu Gallery
//
//  Created by Lexon on 2/12/2020.
//

import UIKit

struct Image: Decodable {
    var id: String
    var author: String
    var width: Int
    var height: Int
    var url: String
    var downloadUrl: String
    
    var uiImage: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }
}
