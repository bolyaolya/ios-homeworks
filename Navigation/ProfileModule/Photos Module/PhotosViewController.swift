//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.01.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController : UIViewController {
    
    //свойства
    
    enum Constants {
        static let defaultCellID = "DefaultCellID"
        static let photosCellID = "PhotosCellID"
        
        static let numberOfColumns : CGFloat = 3
        static let minimumInteritemSpacing : CGFloat = 8
        static let inset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    var imagePublisher = ImagePublisherFacade()
    var dataSource = Photos.massiveOfPhotos()
    var Massiveimages = [UIImage]()
    
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
    
    struct Photos {
        let image : String
        static func massiveOfPhotos() -> [Photos] {
            return [
                Photos(image: "1"),
                Photos(image: "2"),
                Photos(image: "3"),
                Photos(image: "4"),
                Photos(image: "5"),
                Photos(image: "6"),
                Photos(image: "7"),
                Photos(image: "8"),
                Photos(image: "9"),
                Photos(image: "10"),
                Photos(image: "11"),
                Photos(image: "12"),
                Photos(image: "13"),
                Photos(image: "14"),
                Photos(image: "15"),
                Photos(image: "16"),
                Photos(image: "17"),
                Photos(image: "18"),
                Photos(image: "19"),
                Photos(image: "20")
            ]
        }
    }
    
    //жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationController?.navigationBar.isHidden = false
        
        imagePublisher.subscribe(self)
        imagePublisher.addImagesWithTimer(time: 3.0, repeat: 20)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imagePublisher.removeSubscription(for: self)
        imagePublisher.rechargeImageLibrary()
    }
    
    // методы
    
    private func setupView() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
        setupConstraints()
        setupNavBarTitle()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
             self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
             self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
             self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
             self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupNavBarTitle() {
        navigationItem.title = "Photo Gallery"
    }
}

extension PhotosViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
   
    //количество элементов
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Photos.massiveOfPhotos().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photosCellID, for: indexPath) as? PhotosCollectionViewCell
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.defaultCellID, for: indexPath)
            return cell
        }
        
        let photos = Photos.massiveOfPhotos()[indexPath.row]
        cell.imageView.image = UIImage(named: photos.image)
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
extension PhotosViewController : ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        Massiveimages = images
        collectionView.reloadData()
    }
}
