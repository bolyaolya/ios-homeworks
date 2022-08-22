//
//  FirstTabVC.swift
//  Navigation
//
//  Created by Ольга Бойко on 15.08.2022.
//

import UIKit


class FirstTabVC: UIViewController {
    
    struct Post {
        let title: String
    }
    
    let postTitle: Post = .init(title: "First post")
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Show post", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)
        button.layer.cornerRadius = 14
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
        button.center = self.view.center
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    func setupConstraints() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    
    
    @objc func tap() {
        let post = PostViewController()
        navigationController?.pushViewController(post, animated: true)
    }
}

