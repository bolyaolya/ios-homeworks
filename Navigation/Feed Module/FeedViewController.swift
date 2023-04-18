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
        but1.backgroundColor = .systemBlue
        but1.layer.cornerRadius = 10
        but1.translatesAutoresizingMaskIntoConstraints = false
        but1.addTarget(FeedViewController.self, action: #selector(tap), for: .touchUpInside)
        return but1
    }()
    
    let secondButton : UIButton = {
        let but2 = UIButton()
        but2.setTitle("Two", for: .normal)
        but2.backgroundColor = .systemBlue
        but2.layer.cornerRadius = 10
        but2.translatesAutoresizingMaskIntoConstraints = false
        but2.addTarget(FeedViewController.self, action: #selector(tap), for: .touchUpInside)
        return but2
    }()
    
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .systemBlue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
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
        view.backgroundColor = .white
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
//            stackView.widthAnchor.constraint(equalToConstant: 200),
//            stackView.heightAnchor.constraint(equalToConstant: 200),
            
            firstButton.heightAnchor.constraint(equalToConstant: 30),
            firstButton.widthAnchor.constraint(equalToConstant: 50),
            
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 40),
            secondButton.heightAnchor.constraint(equalToConstant: 30),
            secondButton.widthAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc func tap() {
        let post = PostViewController()
        navigationController?.pushViewController(post, animated: true)
    }
}

