//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Ольга Бойко on 10.05.2023.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login : String, password : String) -> Bool
}
