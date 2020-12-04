//
//  ViewController.swift
//  Momatu Gallery
//
//  Created by Lexon on 1/12/2020.
//

import SnapKit

class GridViewController: UIViewController {
    
    private var currentPage = 1
    
    private var images = [Image]()
    
    //MARK: UI Elements

    let collectionView: UICollectionView = {
        let layout = GridLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupCollectionView()
        Server.shared.fetchImages(page: currentPage, completion: { (images) in
            guard let images = images else { return }
            self.currentPage += 1
            self.images = images
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    //MARK: Setup UI methods
    
    private func addSubviews() {
        [collectionView].forEach { (subview) in
            view.addSubview(subview)
        }
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
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
}

extension GridViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.image = images[indexPath.item]
        return cell
    }
}

extension GridViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //handle pagination
        if indexPath.item == images.count - GridConstants.numberOfItemsTillEndForLoading {
            Server.shared.fetchImages(page: currentPage) { (images) in
                guard let images = images else { return }
                self.images.append(contentsOf: images)
                self.currentPage += 1
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension GridViewController: GridLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let image = images[indexPath.item]
        let width = collectionView.frame.width/CGFloat(GridConstants.numberOfColumns) - GridConstants.cellPadding * 2
        let height = CGFloat(image.height * Int(width)/image.width) + ImageCellConstants.authorLabelHeight
        return height
    }
}
