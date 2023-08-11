//
//  Checker.swift
//  Navigation
//
//  Created by Ольга Бойко on 03.05.2023.
//

import UIKit

final class Checker {
    
    static let shared  = Checker()
    
    private let login : String
    private let password : String
    
    private init() {
        login = "test"
        password = "test"
    }
    
    func check(login : String, password: String) -> Bool {
        self.login == login && self.password == password ? true : false
    }
}
