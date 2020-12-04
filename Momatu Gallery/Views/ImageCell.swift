//
//  ImageCell.swift
//  Momatu Gallery
//
//  Created by Lexon on 2/12/2020.
//

import SnapKit

class ImageCell: UICollectionViewCell {
    
    static let identifier = "ImageCell"
    
    let prefix = ImageCellConstants.authorLabelPrefix
    
    var image: Image? {
        didSet {
            guard var image = image else { return }
            
            //MARK: Populate authorLabel UI
            let attributedString = NSMutableAttributedString(string: prefix + image.author)
            //make the prefix bold
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 15), range: NSRange(location: 0, length: prefix.count))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: prefix.count, length: image.author.count))
            self.authorLabel.attributedText = attributedString
            
            //MARK: Populate imageView
            self.imageView.image = nil
            Cache.shared.loadImage(withUrl: image.imageUrl) { [weak self] (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
    
    //MARK: UI Elements
    
    let imageView = UIImageView()
    let imageShadowView = UIView()
    let authorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupImageView()
        setupImageShadowView()
        setupAuthorLabel()
    }
    
    //MARK: Setup UI methods
    
    private func addSubviews() {
        [imageShadowView, imageView, authorLabel].forEach { (subview) in
            contentView.addSubview(subview)
        }
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = ImageCellConstants.imageViewCornerRadius
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(authorLabel.snp.top)
        }
    }
    
    private func setupImageShadowView() {
        imageShadowView.layer.cornerRadius = ImageCellConstants.imageViewCornerRadius
        imageShadowView.backgroundColor = .white
        imageShadowView.addShadow()
        imageShadowView.snp.makeConstraints { (make) in
            //Note: `make.left.equalTo(imageView.snp.edges)` causes a memory error
            make.left.equalTo(imageView.snp.left)
            make.right.equalTo(imageView.snp.right)
            make.bottom.equalTo(imageView.snp.bottom)
            make.top.equalTo(imageView.snp.top)
        }
    }
    
    private func setupAuthorLabel() {
        authorLabel.font = UIFont.systemFont(ofSize: 15)
        authorLabel.snp.makeConstraints { (make) in
            make.height.equalTo(ImageCellConstants.authorLabelHeight)
            make.left.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
