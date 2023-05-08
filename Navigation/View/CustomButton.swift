//
//  CustomButton.swift
//  Navigation
//
//  Created by Ольга Бойко on 05.05.2023.
//

import UIKit

class CustomButton : UIButton {
    
    var actionButton : () -> Void = {}
    
    //кастомный инициализатор с параметрами кнопки
    init(title: String, titleColor: UIColor = .white, backgroundColor : UIColor = .systemBlue, cornerRadius : CGFloat = 10) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        actionButton()
    }
}
