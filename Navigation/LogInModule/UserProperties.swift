//
//  UserProperties.swift
//  Navigation
//
//  Created by Ольга Бойко on 01.05.2023.
//

import UIKit

protocol UserService {
    func checkLogin (login : String) -> User?
}

final class User {
    var login : String?
    var fullName : String?
    var avatar : UIImage?
    var status : String?
}

final class CurrentUserService : UserService {
    
    let user = User()
    
    func checkLogin(login: String) -> User? {
        return user.login == login ? user : nil
    }
}

final class TestUserService : UserService {
    
    let user: User = {
        let user = User()
        user.login = "1234"
        user.fullName = "Olga Boyko"
        user.status = "Waiting For Something"
        user.avatar = UIImage(named: "jdun")
        return user
    }()
    
    func checkLogin(login: String) -> User? {
        return user
    }
}
