//
//  LoginFactory.swift
//  Navigation
//
//  Created by Ольга Бойко on 10.05.2023.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
