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
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchByAuthor))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(deleteFilter))
        navigationItem.rightBarButtonItems = [searchButton, deleteButton]
        
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
    
    @objc private func searchByAuthor() {
        searchField(title: "По автору", actionHandler: { text in
            if let result = text {
                CoreDataManager.defaultManager.getSearchResult(by: result)
                self.tableView.reloadData()
            }
        })
    }
    
    @objc private func deleteFilter() {
        CoreDataManager.defaultManager.reloadPosts()
        tableView.reloadData()
    }
}

extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.defaultManager.favPosts.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
        cell.setupFromCoreData(post : CoreDataManager.defaultManager.favPosts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action, swipeButtonView, completion) in
            CoreDataManager.defaultManager.deletePostFromFav(post: CoreDataManager.defaultManager.favPosts[indexPath.row])
            CoreDataManager().reloadPosts()
            self.tableView.reloadData()
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension UIViewController {
    func searchField(title : String? = nil,
                     subtitle : String? = nil,
                     inputText : String? = nil,
                     inputKeyboardType : UIKeyboardType = UIKeyboardType.default,
                     actionTitle : String? = "Поиск",
                     cancelTitle : String? = "Отмена",
                     cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                     actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField : UITextField) in
            textField.placeholder = inputText
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action : UIAlertAction) in
            guard let textField = alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        self.present(alert, animated: true)
    }
}















