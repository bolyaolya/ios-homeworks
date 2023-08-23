//
//  AppDelegate.swift
//  Navigation
//
//  Created by Ольга Бойко on 14.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let localNS = LocalNotificationsService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        localNS.registerForLatestUpdatesIfPossible()
        
        FirebaseApp.configure()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut()
        } catch {}
    }
    
}

