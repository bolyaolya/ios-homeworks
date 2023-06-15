//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 22.08.2022.
//

import UIKit

class InfoViewController : UIViewController {
    
    private lazy var button : CustomButton = CustomButton(title: "New alert")
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "\(titleText)"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var citizenLabel : UILabel = {
        let label = UILabel()
        label.text = "\(orbitalPeriod)"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(taptap), for: .touchUpInside)
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(button)
        view.addSubview(titleLabel)
        view.addSubview(citizenLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            citizenLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            citizenLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.heightAnchor.constraint(equalToConstant: 80),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: citizenLabel.bottomAnchor, constant: 50)
        ])
    }
    
    @objc func taptap() {
        
        let alertMessage = UIAlertController(title: "Hello", message: "It's me", preferredStyle: .alert)
        let answer = UIAlertAction(title: "Hello Adele", style: .default, handler: { _ in
            print("Hello Adele")
        })
        let answer1 = UIAlertAction(title: "Bye Adele", style: .default, handler: { _ in
            print("Bye Adele")
        })
        alertMessage.addAction(answer)
        alertMessage.addAction(answer1)
        self.present(alertMessage, animated: true)
    }
}
