//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.01.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController : UIViewController {
    
    //MARK: - Properties
    
    enum Constants {
        static let defaultCellID = "DefaultCellID"
        static let photosCellID = "PhotosCellID"
        
        static let numberOfColumns : CGFloat = 3
        static let minimumInteritemSpacing : CGFloat = 8
        static let inset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    let imagePublisher = ImagePublisherFacade()
    private var dataSource = photos.makePhotoArray()
    private var imagesArray = [UIImage]()
    private var localImages = [UIImage]()
    
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.sectionInset = Constants.inset
        return layout
    }()
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.defaultCellID)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: Constants.photosCellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    struct photos {
        let image : String
        static func makePhotoArray() -> [photos] {
            return [
                photos(image: "1"),
                photos(image: "2"),
                photos(image: "3"),
                photos(image: "4"),
                photos(image: "5"),
                photos(image: "6"),
                photos(image: "7"),
                photos(image: "8"),
                photos(image: "9"),
                photos(image: "10"),
                photos(image: "11"),
                photos(image: "12"),
                photos(image: "13"),
                photos(image: "14"),
                photos(image: "15"),
                photos(image: "16"),
                photos(image: "17"),
                photos(image: "18"),
                photos(image: "19"),
                photos(image: "20")
            ]
        }
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationController?.navigationBar.isHidden = false
        
        setupImages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imagePublisher.removeSubscription(for: self)
        imagePublisher.rechargeImageLibrary()
    }
    
    //MARK: - Methods
    
    private func setupView() {
        view.backgroundColor = colorMainBackground
        setupNavBarTitle()
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupImages() {
        dataSource.forEach {
            guard let image = UIImage(named: $0.image) else { return }
            localImages.append(image)
        }
        imagePublisher.subscribe(self)
        imagePublisher.addImagesWithTimer(time: 1.0, repeat: 20, userImages: localImages)
    }
    
    private func setupNavBarTitle() {
        navigationItem.title = "Photo Gallery"
    }
}

extension PhotosViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        imagesArray = images
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photosCellID, for: indexPath) as? PhotosCollectionViewCell
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.defaultCellID, for: indexPath)
            return cell
        }
        
        let image = imagesArray[indexPath.row]
        cell.imageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.inset
    }
    
    //расчет ширины и отступов
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interitemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? .zero
        let width = collectionView.frame.width - (Constants.numberOfColumns - 1) * interitemSpacing - sectionInset.left - sectionInset.right
        let itemWidth = floor(width / Constants.numberOfColumns)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
