//
//  UserProperties.swift
//  Navigation
//
//  Created by Ольга Бойко on 01.05.2023.
//

import UIKit

//protocol UserService {
//    func checkLogin (login : String) -> User?
//}

class User {
    let login : String
    let avatar : UIImage
    let status : String
    
    init(login: String, avatar: UIImage, status: String) {
        self.login = login
        self.avatar = avatar
        self.status = status
    }
}

final class CurrentUserService {
    
    let user : User
    
//    func checkLogin(login: String) -> User? {
//        return user.login == login ? user : nil
//    }
    
    init(user: User) {
        self.user = user
    }
}

final class TestUserService {
    
    let user: User
    
//    func checkLogin(login: String) -> User? {
//        return user
//    }
    
    init(user: User) {
        self.user = user
    }
}
