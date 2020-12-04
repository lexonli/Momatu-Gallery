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
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }
    
    //returns the image url with the optimized size for the screen
    lazy var imageUrl: String = {
        var pixelWidth = width
        var pixelHeight = height
        
        if width > ImageConstants.maxPixelWidth {
            pixelWidth = ImageConstants.maxPixelWidth
            pixelHeight = height * pixelWidth / width
        }
        
        return "\(PicsumConstants.photoBaseUrl)/\(id)/\(pixelWidth)/\(pixelHeight)"
    }()
}
