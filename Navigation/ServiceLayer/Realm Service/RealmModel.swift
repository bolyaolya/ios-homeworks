//
//  RealmModel.swift
//  Navigation
//
//  Created by Ольга Бойко on 26.07.2023.
//

import Foundation
import UIKit
import RealmSwift

class RealmUsers : Object {
    @Persisted (primaryKey: true) var primaryKey : ObjectId
    
    @Persisted var login : String
    @Persisted var password : String
    
    convenience init(login : String, password : String) {
        self.init()
        self.login = login
        self.password = password
    }
}
