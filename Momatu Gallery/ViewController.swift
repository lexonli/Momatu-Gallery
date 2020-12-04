//
//  ViewController.swift
//  Momatu Gallery
//
//  Created by Lexon on 1/12/2020.
//

import SnapKit

class ViewController: UIViewController {
    
    var page = 1
    
    var images = [Image]()

    let collectionView: UICollectionView = {
        let layout = GridLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupCollectionView()
        Server.shared.fetchImages(page: page, completion: { (images) in
            guard let images = images else { return }
            self.page += 1
            self.images = images
            self.numberOfItems += images.count
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
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
        if let layout = collectionView.collectionViewLayout as? GridLayout {
          layout.delegate = self
        }

    }
    
    var numberOfItems = 0
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.image = images[indexPath.item]
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("Will display cell ", indexPath.item)
        if indexPath.item == images.count - 5 {
            print("Scrolled to: ", indexPath.item)
            print("Fetching next 30 items from \(images.count)")
            Server.shared.fetchImages(page: page) { (images) in
                guard let images = images else { return }
                self.images.append(contentsOf: images)
                self.numberOfItems += images.count
                self.page += 1
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension ViewController: GridLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let image = images[indexPath.item]
        let width = collectionView.frame.width/CGFloat(GridConstants.numberOfColumns) - 10
        let height = CGFloat(image.height * Int(width)/image.width) + 40
        return height
    }
}
