//
//  ImageCell.swift
//  Momatu Gallery
//
//  Created by Lexon on 2/12/2020.
//

import SnapKit

class ImageCell: UICollectionViewCell {
    
    static let identifier = "ImageCell"
    
    let prefix = "By "
    
    var image: Image? {
        didSet {
            guard var image = image else { return }
            
            let attributedString = NSMutableAttributedString(string: prefix + image.author)
            
            //make by bold
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 15), range: NSRange(location: 0, length: prefix.count))
            
            //make author text font
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: prefix.count, length: image.author.count))
            
            self.authorLabel.attributedText = attributedString
            
            //add image
            self.imageView.image = nil
            Cache.shared.loadImage(withUrl: image.imageUrl) { [weak self] (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self?.imageView.image = image
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
            make.bottom.equalTo(authorLabel.snp.top)
        }
    }
    
    private func setupAuthorLabel() {
        authorLabel.text = "Peter Johnson"
        authorLabel.backgroundColor = .yellow
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
