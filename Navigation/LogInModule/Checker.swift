//
//  Checker.swift
//  Navigation
//
//  Created by Ольга Бойко on 03.05.2023.
//

import UIKit

class Checker {
    
    static let shared  = Checker()
    
    private let login : String = "test"
    private let password : String = "test"
    
    private init() {
    }
    
    func check(login : String, password: String) -> Bool {
        self.login == login && self.password == password ? true : false
    }
}

protocol LoginViewControllerDelegate {
    func check(login : String, password : String) -> Bool
}

struct LoginInspector : LoginViewControllerDelegate {
    func check(login : String, password: String) -> Bool {
        let checker = Checker.shared
        return checker.check(login: login, password: password)
    }
}
