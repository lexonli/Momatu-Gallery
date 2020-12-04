//
//  Constants.swift
//  Momatu Gallery
//
//  Created by Lexon on 3/12/2020.
//

import UIKit

struct ImageConstants {
    
    //An approximate image width for the resolution of the phone depending on columns of the grid
    static let maxPixelWidth: Int = {
        let nativeWidth = UIScreen.main.nativeBounds.width
        let nativeHeight = UIScreen.main.nativeBounds.height

        let horizontalLength = min(nativeWidth, nativeHeight)
        return Int(horizontalLength / CGFloat(GridConstants.numberOfColumns))
    }()
}

struct GridConstants {
    static let numberOfColumns: Int = 2
    //number of items before the last indexPath item in the collectionView when we fetch the next page of images
    static let numberOfItemsTillEndForLoading: Int = 5
    static let cellPadding: CGFloat = 6
}

struct PicsumConstants {
    static let photoBaseUrl = "https://picsum.photos/id"
    static let photoListUrl = "https://picsum.photos/v2/list"
}

struct ImageCellConstants {
    static let authorLabelHeight: CGFloat = 40
    static let authorLabelPrefix = "By "
    static let imageViewCornerRadius: CGFloat = 10
}
