//
//  CheckerService.swift
//  Navigation
//
//  Created by Ольга Бойко on 20.06.2023.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password : String, complition : @escaping (String) -> Void)
    func signUp(email: String, password : String, complition : @escaping (String) -> Void)
}

final class CheckerService : CheckerServiceProtocol {
    func checkCredentials(email: String, password : String, complition : @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                let result = error?.localizedDescription as? String
                if let response = result {
                    complition(response)
                }
            } else {
                complition("authorization completed")
            }
        }
    }
    
    func signUp(email: String, password : String, complition : @escaping (String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                let result = error?.localizedDescription as? String
                if let result = result {
                    complition(result)
                }
            } else {
                complition("registration completed")
            }
        }
    }
}


