//
//  FavoritesViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 27.07.2023.
//

import Foundation
import UIKit

final class FavoritesViewController : UIViewController {

    
    //MARK: - Properties
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(UITableViewCell  .self, forCellReuseIdentifier: "DefaultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var data : [Favorite] = []
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Favorites"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.defaultManager.reloadPosts()
        tableView.reloadData()
    }  
}

extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.defaultManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
        cell.setupFromCoreData(post : CoreDataManager.defaultManager.posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action, swipeButtonView, completion) in
            CoreDataManager.defaultManager.deletePostFromFav(post: CoreDataManager.defaultManager.posts[indexPath.row])
            CoreDataManager().reloadPosts()
            self.tableView.reloadData()
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
