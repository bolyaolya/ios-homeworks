//
//  LogInViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 14.09.2022.
//

import UIKit

class LogInViewController : UIViewController, UITextFieldDelegate {
    
    //создаю скроллвью
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    //создаю стек
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //лого
    lazy var logo : UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "vkLogo")
        logo.clipsToBounds = true
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    //кнопка
    lazy var button : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(patternImage: UIImage(named: "blue_pixel")!)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    //поле email
    lazy var email : UITextField = {
        let email = UITextField()
        email.textColor = .black
        email.font = .systemFont(ofSize: 16, weight: .regular)
        email.placeholder = "Email or phone"
        email.keyboardType = .emailAddress
        email.clearButtonMode = .whileEditing
        email.returnKeyType = .continue
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: email.frame.height))
        email.leftViewMode = .always
        email.delegate = self
        email.autocapitalizationType = .none
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    //поле пароль
    lazy var password : UITextField = {
        let password = UITextField()
        password.textColor = .black
        password.font = .systemFont(ofSize: 16, weight: .regular)
        password.placeholder = "Password"
        password.returnKeyType = .done
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: password.frame.height))
        password.leftViewMode = .always
        password.delegate = self
        password.isSecureTextEntry = true
        password.autocapitalizationType = .none
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    lazy var horizontalLine: UIView = {
        let horizontalLine = UIView()
        horizontalLine.backgroundColor = .lightGray
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        return horizontalLine
    }()
    
    func layout() {
        setupGestures()
        view.addSubview(scrollView)
        scrollView.addSubview(logo)
        
        stackView.addArrangedSubview(email)
        stackView.addArrangedSubview(horizontalLine)
        stackView.addArrangedSubview(password)
        scrollView.addSubview(stackView)
        
        scrollView.addSubview(button)
        
    }
    
    //обработка скрытия клавиатуры
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)


            // наблюдаем за уведомлениями об появлении или исчезнавении клавиатуры
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.didShowKeyboard(_:)),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.didHideKeyboard(_:)),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        }

        // функция для обработки тапа и сокрытия клавиатуры
        private func setupGestures() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
            self.view.addGestureRecognizer(tapGesture)
        }

        // функция когда скрывает клавиатура, тут мы все считаем и определяем перекрытие
        @objc func didShowKeyboard(_ notification: Notification){
            print("show keyboard")

            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height

                // считаем нужную точку и проверяем перекрывает ли клавиатура кнопку
                let loginButtonBottomPointY = self.button.frame.origin.y + button.frame.height

                let keyboardOriginY = self.view.frame.height - keyboardHeight

                let yOffset = keyboardOriginY < loginButtonBottomPointY
                ? loginButtonBottomPointY - keyboardOriginY + 32
                : 0

                self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
            }
        }
    
    
    
    
        // функции сокрытия клавиатуры
        @objc func didHideKeyboard(_ notification: Notification){
            self.hideKeyboard()
        }
    
    @objc func forceHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    
        @objc private func hideKeyboard() {
            self.view.endEditing(true)
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    // ------------------------
    
    @objc func login() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate(
            [scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
             
             logo.heightAnchor.constraint(equalToConstant: 100),
             logo.widthAnchor.constraint(equalToConstant: 100),
             logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
             logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             
             stackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
             stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
             stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             stackView.heightAnchor.constraint(equalToConstant: 100),

             email.heightAnchor.constraint(equalToConstant: 49.75),
             email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             email.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),

             password.heightAnchor.constraint(equalToConstant: 49.75),
             password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 0.5),
             password.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
             
             horizontalLine.heightAnchor.constraint(equalToConstant: 0.5),
             horizontalLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             horizontalLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             horizontalLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

             button.heightAnchor.constraint(equalToConstant: 50),
             button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
             button.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
             button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
   //          self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
             
             
        ])
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGestures()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        layout()
        
        setupConstraints()
    }
}

extension LogInViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            self.password.becomeFirstResponder()
        } else {
            self.forceHidingKeyboard()
        }
        return true
    }
}
