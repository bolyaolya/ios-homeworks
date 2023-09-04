//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Ольга Бойко on 05.01.2023.
//

import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    //MARK: свойства
    
    enum PostErrors : Error {
        case connectionFailed
        case undefined
        case noPosts
    }
    
//    var post : ViewModel?
    
    var imgPost: String = ""
    var id: Int = 0
    var likesPost : Int = 0
    var viewsPost : Int = 0
    
    struct ViewModel {
        let id: Int?
        let author: String
        let description: String
        let likes: String
        let views: String
        let image: UIImage?
    }
    
    private lazy var authorLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        label.bounds.size.height = 44
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let description = UILabel()
        description.font = .systemFont(ofSize: 14, weight: .regular)
        description.backgroundColor = .clear
        description.bounds.size.height = 44
        description.textColor = .systemGray
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var likesLabel : UILabel = {
        let likes = UILabel()
        likes.font = .systemFont(ofSize: 16)
        likes.textAlignment = .left
        likes.textColor = .black
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()
    
    private lazy var viewsLabel : UILabel = {
        let views = UILabel()
        views.font = .systemFont(ofSize: 16)
        views.textAlignment = .right
        views.textColor = .black
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    
    //MARK: жизненный цикл
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
        addPostGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: методы
    
    private func layout() {
        setupViews()
        setupConstraints()
    }
    
    public func setup(with viewModel : ViewModel)  {
        self.authorLabel.text = viewModel.author
        self.image.image = viewModel.image
        self.descriptionLabel.text = viewModel.description
        self.likesLabel.text = "Likes: " + String(viewModel.likes)
        self.viewsLabel.text = "Views: " + String(viewModel.views)
        
        self.id = viewModel.id!
        self.imgPost = "viewModel.image"
        self.likesPost = Int(viewModel.likes) ?? 0
        self.viewsPost = Int(viewModel.views) ?? 0
//            self.post = viewModel
    }
    
    public func setupFromCoreData(post : Favorite) {
        authorLabel.text = post.author
        descriptionLabel.text = post.descriptionText
        image.image = UIImage(named: post.image ?? "")
        likesLabel.text = "Likes: " + String(post.likes)
        viewsLabel.text = "Views: " + String(post.views)
    }
    
    func addPostGesture() {
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(postTapped))
        gestureRecogniser.numberOfTapsRequired = 2
        self.addGestureRecognizer(gestureRecogniser)
    }
    
    @objc func postTapped() {
        savedToFavAlert(message: "Do you want to save this post to Favorites?")
    }
    
    func savedToFavAlert(message : String) {
        let alert = UIAlertController(title: "Saving to Favorites", message: message, preferredStyle: .alert)
        let actionOne = UIAlertAction(title: "OK", style: .default) { [self] actionOne in
            savePostToCoreData()
        }
        let actionTwo = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        
        
        
        UIApplication.topViewController()?.present(alert, animated: true)
    }
    
    //почему-то не работает
    func successfulSave() {
        let alert = UIAlertController(title: "Done!", message: .none, preferredStyle: .alert)
        let answer = UIAlertAction(title: "ok", style: .default)
        alert.addAction(answer)
    }
    
    func savePostToCoreData() {
        
        let posts = CoreDataManager().getPosts()
        var postIndex : [Int] = []
        
        if posts.isEmpty {
            print("post is empty")
            CoreDataManager().addPostToFav(author: authorLabel.text!, descriptionText: descriptionLabel.text!, image: imgPost, likes: likesPost, views: viewsPost, id: id)
        } else {
            for p in posts {
                postIndex.append(Int(p.id))
            }
            
            if let index = postIndex.firstIndex(of: id) {
                print("Этот пост \(index) уже добавлен в избранное")
            } else {
                CoreDataManager().addPostToFav(author: authorLabel.text!, descriptionText: descriptionLabel.text!, image: imgPost, likes: likesPost, views: viewsPost, id: id)
            }
        }
    }
    
    private func setupViews() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(image)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            image.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: 450),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
