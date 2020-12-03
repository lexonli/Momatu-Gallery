//
//  ViewController.swift
//  Momatu Gallery
//
//  Created by Lexon on 1/12/2020.
//

import SnapKit

class ViewController: UIViewController {
    
    var images = [Image]() {
        didSet {
            collectionView.reloadData()
        }
    }

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupCollectionView()
        Server.shared.fetchImages(completion: { (images) in
            guard let images = images else { return }
            self.images = images
        })
    }
    
    private func addSubviews() {
        [collectionView].forEach { (subview) in
            view.addSubview(subview)
        }
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .red
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }


}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.image = images[indexPath.item]
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = images[indexPath.item]
        let width = view.frame.width/2 - 10
        let height = CGFloat(image.height * Int(width)/image.width)
        print("height: ", height)
        return CGSize(width: width, height: height)
    }
}
