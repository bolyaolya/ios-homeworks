//
//  LoginFactory.swift
//  Navigation
//
//  Created by Ольга Бойко on 03.05.2023.
//

import UIKit

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory : LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
