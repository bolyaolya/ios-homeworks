//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.08.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView : UITableViewHeaderFooterView {
    
    //MARK: - Properties
    
    private lazy var avatarImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "hypno")
        image.layer.borderWidth = 3
        image.layer.borderColor = colorBorderColor.cgColor
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var fullNameLabel : UILabel = {
        let name = UILabel()
        name.text = "Ждун Ждуновский"
        name.font = .systemFont(ofSize: 18, weight: .bold)
        name.textColor = colorTextColor
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var setStatusButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle(NSLocalizedString("statusButton.title", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = colorTextColor.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var statusLabel : UILabel = {
        let status = UILabel()
        status.text = "Waiting for something..."
        status.font = .systemFont(ofSize: 14, weight: .regular)
        status.textColor = colorTextColor
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    private lazy var statusTextField : UITextField = {
        let statusField = UITextField()
        statusField.backgroundColor = .white
        statusField.layer.borderColor = colorBorderColor.cgColor
        statusField.layer.borderWidth = 1
        statusField.layer.cornerRadius = 12
        statusField.font = .systemFont(ofSize: 15, weight: .regular)
        statusField.textColor = colorTextColor
        statusField.textAlignment = .center
        statusField.translatesAutoresizingMaskIntoConstraints = false
        return statusField
    }()
    
    private var statusText = String()
    
    //MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func setup(user: User) {
        statusLabel.text = user.status
        avatarImageView.image = user.avatar
        fullNameLabel.text = user.login
    }
    
    private func addAllSubviews() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
    }
    
    private func layout() {
        addAllSubviews()
        setupConstraints()
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    private func setupConstraints() {
        
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
    
    @objc
    private func statusTextChanged(_ textField: UITextField) {
        if let text = textField.text {
            statusText = text
        }
    }
    
    @objc
    private func buttonPressed() {
        statusLabel.text = statusText
        statusTextField.text = ""
    }
}
