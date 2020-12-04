//
//  Constants.swift
//  Momatu Gallery
//
//  Created by Lexon on 3/12/2020.
//

import UIKit

struct ImageConstants {
    static let maxPixelWidth: Int = {
        let nativeWidth = UIScreen.main.nativeBounds.width
        let nativeHeight = UIScreen.main.nativeBounds.height

        let horizontalLength = min(nativeWidth, nativeHeight)
        return Int(horizontalLength / CGFloat(GridConstants.numberOfColumns))
    }()
}

struct GridConstants {
    static let numberOfColumns = 2
}

struct PicsumConstants {
    static let photoBaseUrl = "https://picsum.photos/id"
}
