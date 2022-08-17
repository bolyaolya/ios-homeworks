//
//  PostViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 17.08.2022.
//

import UIKit

class PostViewController : UIViewController {
    
    let fromFirstTab = FirstTabVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = fromFirstTab.postTitle.title
        self.view.backgroundColor = .lightGray
    }
    
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(InfoView))
    
    @objc func InfoView() {
        let infoView = SecondTabVC()
        navigationController?.present(infoView, animated: true)
    }
}


