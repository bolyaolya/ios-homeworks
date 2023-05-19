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
    
    let checkFunc = FeedViewModel()
    
    //MARK: свойства
    
    private lazy var btn1 = CustomButton(title: "First button")
    private lazy var btn2 = CustomButton(title: "Second button")
    
    lazy var textField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Set your password"
        textField.text = "secretWord"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var checkGuessButton = CustomButton(title: "check guess button!")
    private lazy var resultBtn = CustomButton(title: "check your result!")
    
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10.0
        return stackView
    }()
    
    var answerText : UILabel = {
        let answerText = UILabel()
        answerText.translatesAutoresizingMaskIntoConstraints = false
        return answerText
    }()
    
    let postTitle: Post = .init(title: "First post")
    
    //MARK: жизненный цикл

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
    }
    
    //MARK: методы
    
    private func setupView() {
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(btn1)
        stackView.addArrangedSubview(btn2)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(checkGuessButton)
        stackView.addArrangedSubview(resultBtn)
        stackView.addArrangedSubview(answerText)
        
        addBtnActions()
        addTargets()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            textField.topAnchor.constraint(equalTo: btn2.bottomAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -40),
            textField.heightAnchor.constraint(equalToConstant: 30),
            
            answerText.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 60),
            answerText.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }
    
    //добавляем действие по тапу - проверка кодового слова
    func addTargets() {
        checkGuessButton.actionButton = {
            self.checkFunc.checkingPassword()
        }
    }
    
    func addBtnActions() {
        
        //добавляем переход по тапу
        btn1.actionButton = {
            let post = PostViewController()
            self.navigationController?.pushViewController(post, animated: true)
        }
        
        //задаем 2-ой кнопке то же действие
        btn2.actionButton = btn1.actionButton
    }
}

