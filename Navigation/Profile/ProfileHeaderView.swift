//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.08.2022.
//

import UIKit
import SwiftUI

class ProfileHeaderView : UIView {
    
    let image : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "hypno")
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true 
        return image
    }()
    
    let name : UILabel = {
        let name = UILabel()
        name.text = "Ждун Ждуновский"
        name.font = .systemFont(ofSize: 18, weight: .bold)
        name.textColor = .black
        return name
    }()
    
    let button : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    let status : UILabel = {
        let status = UILabel()
        status.text = "Waiting for something..."
        status.font = .systemFont(ofSize: 14, weight: .regular)
        status.textColor = .gray
        return status
    }()
    
    let statusField : UITextField = {
        let statusField = UITextField()
        statusField.backgroundColor = .white
        statusField.layer.borderColor = UIColor.black.cgColor
        statusField.layer.borderWidth = 1
        statusField.layer.cornerRadius = 12
        statusField.font = .systemFont(ofSize: 15, weight: .regular)
        statusField.textColor = .black
        statusField.textAlignment = .center
        statusField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return statusField
    }()
    
    private var statusText = String()
    
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = statusField.text!
    }
    
    @objc func buttonPressed() {
        status.text = statusText
    }
}
