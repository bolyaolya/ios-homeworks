//
//  SecondTabVC.swift
//  Navigation
//
//  Created by Ольга Бойко on 16.08.2022.
//

import UIKit

class SecondTabVC: UIViewController {
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("New alert", for: .normal)
        button.backgroundColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)
        button.layer.cornerRadius = 14
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
        button.center = self.view.center
        button.addTarget(self, action: #selector(taptap), for: .touchUpInside)
        view.backgroundColor = .orange
        view.addSubview(button)
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

