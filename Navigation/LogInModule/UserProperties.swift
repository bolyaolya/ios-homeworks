//
//  UserProperties.swift
//  Navigation
//
//  Created by Ольга Бойко on 01.05.2023.
//

import UIKit

class User {
    let login : String
    let fullName : String
    let avatar : UIImage
    let status : String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

protocol UserService {
    func checkLogin ( login : String) -> User?
}

class CurrentUserService : UserService {
    let user : User
    
    func checkLogin(login: String) -> User? {
        if user.login == login {
            return user
        }
        return nil
    }
    
    init(user: User) {
        self.user = user
    }
}

class TestUserService : UserService {
    
    let user : User
    
    func checkLogin(login: String) -> User? {
        if user.login == login {
            return user
        }
        return nil
    }
    
    init(user: User) {
        self.user = user
    }
}
