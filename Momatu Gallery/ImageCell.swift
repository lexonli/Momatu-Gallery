//
//  ImageCell.swift
//  Momatu Gallery
//
//  Created by Lexon on 2/12/2020.
//

import SnapKit

class ImageCell: UICollectionViewCell {
    
    static let identifier = "ImageCell"
    
    var image: Image? {
        didSet {
            guard var image = image else { return }
            self.authorLabel.text = image.author
            self.imageView.image = nil
            Cache.shared.loadImage(withUrl: image.imageUrl) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    print("storing image")
                    self.imageView.image = image
                    print("done image")
                }
            }
        }
    }
    
    let imageView = UIImageView()
    let authorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .green
        addSubviews()
        setupImageView()
        setupAuthorLabel()
    }
    
    private func addSubviews() {
        [imageView, authorLabel].forEach { (subview) in
            contentView.addSubview(subview)
        }
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupAuthorLabel() {
        authorLabel.text = "Peter Johnson"
        authorLabel.font = UIFont.systemFont(ofSize: 15)
        authorLabel.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
