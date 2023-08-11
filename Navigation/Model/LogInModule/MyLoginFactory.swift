//
//  LoginFactory.swift
//  Navigation
//
//  Created by Ольга Бойко on 03.05.2023.
//

import UIKit

struct MyLoginFactory : LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
