//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.01.2023.
//

import UIKit

final class PhotosTableViewCell : UITableViewCell {
    
    //MARK: - Properties
    
    private lazy var photosView : UIView = {
        let photosView = UIView()
        photosView.backgroundColor = .clear
        photosView.translatesAutoresizingMaskIntoConstraints = false
        return photosView
    }()
    
    private lazy var labelPhotos : UILabel = {
        let labelPhotos = UILabel()
        labelPhotos.text = NSLocalizedString("photos.label", comment: "")
        labelPhotos.textColor = .black
        labelPhotos.font = .systemFont(ofSize: 24, weight: .bold)
        labelPhotos.translatesAutoresizingMaskIntoConstraints = false
        return labelPhotos
    }()
    
    private lazy var forwardArrow : UIImageView = {
        let forwardArrow = UIImageView()
        forwardArrow.image = UIImage(named: "arrow")
        forwardArrow.translatesAutoresizingMaskIntoConstraints = false
        return forwardArrow
    }()
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var firstImage : UIImageView = {
        let firstImage = UIImageView()
        firstImage.image = UIImage(named: "1")
        firstImage.clipsToBounds = true
        firstImage.layer.cornerRadius = 6
        firstImage.contentMode = .scaleAspectFit
        return firstImage
    }()
    
    private lazy var secondImage : UIImageView = {
        let secondImage = UIImageView()
        secondImage.image = UIImage(named: "2")
        secondImage.clipsToBounds = true
        secondImage.layer.cornerRadius = 6
        secondImage.contentMode = .scaleAspectFit
        return secondImage
    }()
    
    private lazy var thirdImage : UIImageView = {
        let thirdImage = UIImageView()
        thirdImage.image = UIImage(named: "3")
        thirdImage.clipsToBounds = true
        thirdImage.layer.cornerRadius = 6
        thirdImage.contentMode = .scaleAspectFit
        return thirdImage
    }()
    
    private lazy var forthImage : UIImageView = {
        let forthImage = UIImageView()
        forthImage.image = UIImage(named: "4")
        forthImage.clipsToBounds = true
        forthImage.layer.cornerRadius = 6
        forthImage.contentMode = .scaleAspectFit
        return forthImage
    }()
    
    //MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func layout() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(photosView)
        photosView.addSubview(labelPhotos)
        photosView.addSubview(forwardArrow)
        photosView.addSubview(stackView)
        stackView.addArrangedSubview(firstImage)
        stackView.addArrangedSubview(secondImage)
        stackView.addArrangedSubview(thirdImage)
        stackView.addArrangedSubview(forthImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [labelPhotos.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
             labelPhotos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
             
             photosView.topAnchor.constraint(equalTo: contentView.topAnchor),
             photosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             photosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             photosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             
             forwardArrow.trailingAnchor.constraint(equalTo: photosView.trailingAnchor, constant: -12),
             forwardArrow.centerYAnchor.constraint(equalTo: labelPhotos.centerYAnchor),
             forwardArrow.heightAnchor.constraint(equalToConstant: 20),
             forwardArrow.widthAnchor.constraint(equalToConstant: 20),
             
             stackView.topAnchor.constraint(equalTo: labelPhotos.bottomAnchor, constant: 12),
             stackView.leadingAnchor.constraint(equalTo: photosView.leadingAnchor, constant: 12),
             stackView.trailingAnchor.constraint(equalTo: photosView.trailingAnchor, constant: -12),
             stackView.bottomAnchor.constraint(equalTo: photosView.bottomAnchor, constant: -12),
             
             firstImage.heightAnchor.constraint(equalTo: firstImage.widthAnchor, multiplier: 1)
            ])
    }
}
