//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.08.2022.
//

import UIKit
import SnapKit

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
        statusField.addTarget(ProfileHeaderView.self, action: #selector(statusTextChanged), for: .editingChanged)
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
    }
    
    func setupConstraints() {
        
        avatarImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.top.equalToSuperview().inset(19)
            make.leading.equalToSuperview().inset(16)
        }

        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.leading.equalTo(avatarImageView.snp.trailing).inset(-16)
            make.height.equalTo(18)
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).inset(-16)
            make.leading.equalTo(avatarImageView.snp.trailing).inset(-16)
        }

        statusTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalTo(avatarImageView.snp.trailing).inset(-16)
            make.top.equalTo(statusLabel.snp.bottom).inset(-20)
            make.trailing.equalToSuperview().inset(16)
        }

        setStatusButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(statusTextField.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(16)

        }
        
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = statusTextField.text!
    }
    
    @objc func buttonPressed() {
        let buttonPressed = UITapGestureRecognizer(target: self, action: #selector(buttonPressed))
        setStatusButton.isUserInteractionEnabled = true
        setStatusButton.addGestureRecognizer(buttonPressed)
        statusLabel.text = statusText
    }
}
