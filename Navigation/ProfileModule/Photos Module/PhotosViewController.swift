//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.01.2023.
//

import UIKit

class PhotosViewController : UIViewController {
    
    //свойства
    
    enum Constants {
        static let defaultCellID = "DefaultCellID"
        static let photosCellID = "PhotosCellID"
        
        static let numberOfColumns : CGFloat = 3
        static let minimumInteritemSpacing : CGFloat = 8
        static let inset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
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
    
    private struct Photos {
        let image : String
    }
    
    private var photos : [Photos] = [
        Photos.init(image: "1"),
        Photos.init(image: "2"),
        Photos.init(image: "3"),
        Photos.init(image: "4"),
        Photos.init(image: "5"),
        Photos.init(image: "6"),
        Photos.init(image: "7"),
        Photos.init(image: "8"),
        Photos.init(image: "9"),
        Photos.init(image: "10"),
        Photos.init(image: "11"),
        Photos.init(image: "12"),
        Photos.init(image: "13"),
        Photos.init(image: "14"),
        Photos.init(image: "15"),
        Photos.init(image: "16"),
        Photos.init(image: "17"),
        Photos.init(image: "18"),
        Photos.init(image: "19"),
        Photos.init(image: "20")
    ]
    
    //жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationController?.navigationBar.isHidden = false
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
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photosCellID, for: indexPath) as? PhotosCollectionViewCell
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.defaultCellID, for: indexPath)
            return cell
        }
        
        let photos = photos[indexPath.row]
        cell.imageView.image = UIImage(named: photos.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interitemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? .zero
        let width = collectionView.frame.width - (Constants.numberOfColumns - 1) * interitemSpacing - sectionInset.left - sectionInset.right
        let itemWidth = floor(width / Constants.numberOfColumns)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

