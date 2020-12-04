//
//  UIView+extension.swift
//  Momatu Gallery
//
//  Created by Lexon on 4/12/2020.
//

import UIKit

extension UIView {
    
    func addShadow() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.shadowRadius = 3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
}
