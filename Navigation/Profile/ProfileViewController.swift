//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.08.2022.
//

import UIKit

class ProfileViewController : UIViewController {
    
    let header = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navBarCustomize()
        
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
    
    override func viewWillLayoutSubviews() {
        header.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        header.frame.origin = CGPoint(x: self.view.safeAreaInsets.left, y: self.view.safeAreaInsets.top)
        
        view.addSubview(header)
        header.addSubview(header.image)
        header.addSubview(header.name)
        header.addSubview(header.button)
        header.addSubview(header.status)
        header.addSubview(header.statusField)
        
        header.image.frame = CGRect(x: 16, y: 16, width: 100, height: 100)
        header.image.layer.cornerRadius = header.image.frame.width / 2
        header.name.frame = CGRect(x: header.image.frame.maxX + 16, y: 27, width: 450, height: 18)
        header.button.frame = CGRect(x: 16, y: header.image.frame.maxY + 36, width: header.frame.width - 32, height: 50)
        header.status.frame = CGRect(x: header.image.frame.maxX + 16, y: header.button.frame.minY - 20 - 56, width: header.frame.width - 32, height: 14)
        header.statusField.frame = CGRect(x: header.status.frame.minX, y: header.status.frame.maxY + 16, width: 200, height: 35)
    }
}
