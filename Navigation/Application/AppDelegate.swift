//
//  AppDelegate.swift
//  Navigation
//
//  Created by Ольга Бойко on 14.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

//    var window: UIWindow?
    
    //Создаем таббар контроллер
//    let tabBarController = UITabBarController()
//    let feedViewController = FeedViewController()
//    let profileViewController = ProfileViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let feed = UINavigationController(rootViewController: feedViewController)
//        let profile = UINavigationController(rootViewController: profileViewController)
        
//        loginDelegate = MyLoginFactory().makeLoginInspector()
//
//        let factory = MyLoginFactory()
//        let loginInspector = factory.makeLoginInspector()
//        let loginVC = LogInViewController()
//        loginVC.loginDelegate = loginInspector
                
//        tabBarController.viewControllers = [feed, profile]
//        feed.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName:"newspaper"), tag: 0)
//        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName:"person"), tag: 1)
//
//
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

