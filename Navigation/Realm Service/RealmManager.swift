//
//  RealmManager.swift
//  Navigation
//
//  Created by Ольга Бойко on 26.07.2023.
//

import Foundation
import UIKit
import RealmSwift

class RealmManager {
    var realm : Realm!
    var realmUsers : [RealmUsers] = []
    
    init() {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        guard let realm = try? Realm() else { fatalError() }
        self.realm = realm
    }
    
    func reloadUserData() {
        realmUsers = Array(realm.objects(RealmUsers.self))
    }
    
    func saveRealmUser(login : String, password : String) {
        do {
            try realm.write {
                let user = RealmUsers(login: login, password: password)
                realm.add(user)
            }
        } catch let error {
            print("Ошибка сохранения пользователя : \(error.localizedDescription)")
        }
    }
}
