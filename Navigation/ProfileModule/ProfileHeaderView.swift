//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.08.2022.
//

import UIKit

class ProfileHeaderView : UITableViewHeaderFooterView {
    
    //свойства
    
    let avatarImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "hypno")
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let fullNameLabel : UILabel = {
        let name = UILabel()
        name.text = "Ждун Ждуновский"
        name.font = .systemFont(ofSize: 18, weight: .bold)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let setStatusButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let statusLabel : UILabel = {
        let status = UILabel()
        status.text = "Waiting for something..."
        status.font = .systemFont(ofSize: 14, weight: .regular)
        status.textColor = .gray
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    let statusTextField : UITextField = {
        let statusField = UITextField()
        statusField.backgroundColor = .white
        statusField.layer.borderColor = UIColor.black.cgColor
        statusField.layer.borderWidth = 1
        statusField.layer.cornerRadius = 12
        statusField.font = .systemFont(ofSize: 15, weight: .regular)
        statusField.textColor = .black
        statusField.textAlignment = .center
        statusField.translatesAutoresizingMaskIntoConstraints = false
        return statusField
    }()
    
    private var statusText = String()
    
    //жизненный цикл
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //методы
    
    func setup(user: User) {
        fullNameLabel.text = user.fullName
        statusLabel.text = user.status
        avatarImageView.image = user.avatar
    }
    
    func addAllSubviews() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
    }
    
    func layout() {
        addAllSubviews()
        setupConstraints()
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
             avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
             avatarImageView.widthAnchor.constraint(equalToConstant: 100),
             avatarImageView.heightAnchor.constraint(equalToConstant: 100),
        
             fullNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 16),
             fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
             fullNameLabel.heightAnchor.constraint(equalToConstant: 18),
        
             statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
             statusLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -46),
             
             statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
             statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20),
             statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
             statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
             setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
             setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 20),
             setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
             setStatusButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        if let text = textField.text {
                statusText = text
        }
    }
    
    @objc func buttonPressed() {
                statusLabel.text = statusText
                statusTextField.text = ""
    }
}
