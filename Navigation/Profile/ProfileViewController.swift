//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.08.2022.
//

import UIKit

class ProfileViewController : UIViewController {
    
    let header = ProfileHeaderView()
    
    let button : UIButton = {
        let button = UIButton()
        button.setTitle("Second button", for: .normal)
        button.backgroundColor = .systemPink
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navBarCustomize()
        view.addSubview(header)
        view.addSubview(button)
        
        header.addAllSubviews()
        header.setupConstraints()
        
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             header.heightAnchor.constraint(equalToConstant: 220)
            ]
        )
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
             button.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    func navBarCustomize () {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = "Profile"
    }
    
    
}
