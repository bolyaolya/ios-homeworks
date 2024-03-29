//
//  PostViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 17.08.2022.
//

import UIKit
import StorageService

class PostViewController : UIViewController {
    
    let fromFirstTab = FeedViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(infoView))
        navigationItem.rightBarButtonItem = button
        self.title = fromFirstTab.postTitle.title
        self.view.backgroundColor = colorSecondaryBackground
    }
    
    @objc func infoView() {
        let infoViewController = InfoViewController()
        navigationController?.present(infoViewController, animated: true)
    }
}
