//
//  ImageCell.swift
//  Momatu Gallery
//
//  Created by Lexon on 2/12/2020.
//

import SnapKit

class ImageCell: UICollectionViewCell {
    
    static let identifier = "ImageCell"
    
    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            imageView.image = image
        }
    }
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .green
        addSubviews()
    }
    
    private func addSubviews() {
        [imageView].forEach { (subview) in
            contentView.addSubview(subview)
        }
    }
    
    private func setupImageView() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
