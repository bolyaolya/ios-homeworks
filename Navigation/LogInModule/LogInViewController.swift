//
//  LogInViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 14.09.2022.
//

import UIKit
import FirebaseAuth
import RealmSwift

final class LogInViewController : UIViewController, UITextFieldDelegate {
    
    //MARK: свойства
    
    var loginDelegate : LoginViewControllerDelegate?
    
    var realmManager = RealmManager()
    
    #if DEBUG
    var userLogin : TestUserService?
    #else
    var userLogin : CurrentUserService?
    #endif
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView : UIStackView = {
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
    
    private lazy var logo : UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "vkLogo")
        logo.clipsToBounds = true
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var loginButton : CustomButton = CustomButton(title: "Log In",
                                                               backgroundColor: UIColor.init(patternImage: UIImage(named: "blue_pixel")!),
                                                               cornerRadius: 10)
    
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
    
    lazy var password : UITextField = {
        let password = UITextField()
        password.textColor = .black
        password.font = .systemFont(ofSize: 16, weight: .regular)
        password.placeholder = "Password"
        password.clearButtonMode = .whileEditing
        password.returnKeyType = .done
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: password.frame.height))
        password.leftViewMode = .always
        password.delegate = self
        password.isSecureTextEntry = true
        password.autocapitalizationType = .none
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    private lazy var horizontalLine: UIView = {
        let horizontalLine = UIView()
        horizontalLine.backgroundColor = .lightGray
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        return horizontalLine
    }()
    
    //MARK: жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userVerification()
        
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
    
    //MARK: методы
    
    private func setupUI() {
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupGestures()
        addBtnActions()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.loginButton.setTitle("Зарегистрироваться", for: .normal)
            } else {
                self.loginButton.setTitle("Войти", for: .normal)
            }
        }
        
        if loginButton.isEnabled || loginButton.isSelected || loginButton.isHighlighted { loginButton.alpha = 0.8 }
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(logo)
        scrollView.addSubview(stackView)
        scrollView.addSubview(loginButton)
        stackView.addArrangedSubview(email)
        stackView.addArrangedSubview(horizontalLine)
        stackView.addArrangedSubview(password)
    }
    
    // функция для обработки тапа и сокрытия клавиатуры
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // функция когда скрывает клавиатура, тут мы все считаем и определяем перекрытие
    @objc func didShowKeyboard(_ notification: Notification){
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            // считаем нужную точку и проверяем перекрывает ли клавиатура кнопку
            let loginButtonBottomPointY = loginButton.frame.origin.y + loginButton.frame.height
            
            let keyboardOriginY = scrollView.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 16
            : 0
            
            scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    // функции скрытия клавиатуры
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
    
    func alertError(message : String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func alertBadLogin(message : String, complition: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Register new user", style: .default) { action in
            complition(true)
        })
        alert.addAction(UIAlertAction(title: "cancel", style: .default))
        self.present(alert, animated: true)
    }
    
    func alertSuccess(message : String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
//    private func addBtnActions() {
//
//        loginButton.actionButton = {
//
//            guard let enteredEmail = self.email.text,
//                  let enteredPassword = self.password.text,
//                  (!enteredEmail.isEmpty && !enteredPassword.isEmpty)
//            else {
//                self.alertError(message: "Введите логин и пароль")
//                return
//            }
//
//            CheckerService().checkCredentials(email: self.email.text!, password: self.password.text!) { result in
//                if result == "authorization completed" {
//                    self.showProfileVC()
//                } else if result == "There is no user record corresponding to this identifier. The user may have been deleted." {
//                    self.alertBadLogin(message: result) { result in
//                        CheckerService().signUp(email: enteredEmail, password: enteredPassword) { result in
//                            if result == "registration completed" {
//                                self.alertSuccess(message: result)
//                            } else {
//                                self.alertError(message: result)
//                            }
//                        }
//                    }
//                } else {
//                    self.alertError(message: result)
//                }
//            }
//        }
//    }
    
    
    private func addBtnActions() {
        
        loginButton.actionButton = {
            
            guard let enteredEmail = self.email.text,
                  let enteredPassword = self.password.text,
                  (!enteredEmail.isEmpty && !enteredPassword.isEmpty)
            else {
                self.alertError(message: "Введите логин и пароль")
                return
            }
            
#if DEBUG
            self.userLogin = TestUserService(user: User(login: "Olya Boyko", avatar: UIImage(named: "avatar") ?? UIImage(), status: "Waiting for smth"))
#else
            self.userLogin = CurrentUserService(user: User(login: "Test Test", avatar: UIImage(named: "hypno") ?? UIImage(), status: "Test"))
#endif
            
            CheckerService().checkCredentials(email: enteredEmail, password: enteredPassword) { result in
                if result == "authorization completed" {
                
                    let profileVC = ProfileViewController()
                    profileVC.userIsLogin = self.userLogin!.user
                    
                    self.realmManager.saveRealmUser(login: enteredEmail, password: enteredPassword)
                    self.navigationController?.pushViewController(profileVC, animated: true)
                    
                } else if result == "There is no user record corresponding to this identifier. The user may have been deleted." {
                    self.alertBadLogin(message: result) { result in
                        CheckerService().signUp(email: enteredEmail, password: enteredPassword) { result in
                            if result == "Registration completed" {
                                self.realmManager.saveRealmUser(login: enteredEmail, password: enteredPassword)
                                self.alertSuccess(message: result)
                            } else {
                                self.alertError(message: result)
                            }
                        }
                    }
                } else {
                    self.alertError(message: result)
                }
            }
        }
    }
    
    func userVerification() {
        realmManager.reloadUserData()
        if !realmManager.realmUsers.isEmpty {
            
        #if DEBUG
            userLogin = TestUserService(user: User(login: "Olya Boyko", avatar: UIImage(named: "avatar") ?? UIImage(), status: "Waiting for smth"))
        #else
            userLogin = CurrentUserService(user: User(login: "Test Test", avatar: UIImage(named: "hypno") ?? UIImage(), status: "Test"))
        #endif
            
            let profileVC = ProfileViewController()
            profileVC.userIsLogin = userLogin!.user
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    private func setupConstraints() {
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
             
             loginButton.heightAnchor.constraint(equalToConstant: 50),
             loginButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
             loginButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
             loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16)
            ])
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

//extension LogInViewController {
//    func showProfileVC() {
//        let user = TestUserService()
//
//        let profileViewController = ProfileViewController(userService: user, name: email.text!)
//        navigationController?.pushViewController(profileViewController, animated: true)
//    }
//}
