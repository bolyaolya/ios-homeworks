//
//  FirstTabVC.swift
//  Navigation
//
//  Created by Ольга Бойко on 15.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    struct Post {
        let title: String
    }
    
    
    let firstButton : UIButton = {
        let but1 = UIButton()
        but1.setTitle("One", for: .normal)
        but1.backgroundColor = .green
        but1.translatesAutoresizingMaskIntoConstraints = false
        but1.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return but1
    }()
    
    let secondButton : UIButton = {
        let but2 = UIButton()
        but2.setTitle("Two", for: .normal)
        but2.backgroundColor = .yellow
        but2.translatesAutoresizingMaskIntoConstraints = false
        but2.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return but2
    }()
    
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .systemBlue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    let postTitle: Post = .init(title: "First post")
    
//    let button: UIButton = {
//        let button = UIButton()
//        button.setTitle("Show post", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.backgroundColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)
//        button.layer.cornerRadius = 14
//        return button
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
//        button.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
//        button.center = self.view.center
//        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
//        view.addSubview(button)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300),
            stackView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    @objc func tap() {
        let post = PostViewController()
        navigationController?.pushViewController(post, animated: true)
    }
}

