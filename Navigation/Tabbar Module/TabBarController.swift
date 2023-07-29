//
//  TabBarController.swift
//  Navigation
//
//  Created by Ольга Бойко on 15.08.2022.
//

import UIKit

final class TabBarController: UITabBarController {

    //MARK: - Properties
    
    var firstTabNavController : UINavigationController!
    var secondTabNavController : UINavigationController!
    var thirdTabNavController : UINavigationController!
    
#if DEBUG
    var userLogin : TestUserService = TestUserService(user: User(login: "Olya Boyko", avatar: UIImage(named: "avatar") ?? UIImage(), status: "Waiting for smth"))
#else
    var userLogin : CurrentUserService = CurrentUserService(user: User(login: "Test Test", avatar: UIImage(named: "hypno") ?? UIImage(), status: "Test"))
#endif
    
    var userIsLogin : User = User(login: "", avatar: UIImage(), status: "")
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        
//        let feedVC = FeedViewController()
        let profileVC = ProfileViewController()
        let favVC = FavoritesViewController()
        
        profileVC.userIsLogin = self.userLogin.user
        
//        firstTabNavController = UINavigationController.init(rootViewController: feedVC)
        secondTabNavController = UINavigationController.init(rootViewController: profileVC)
        thirdTabNavController = UINavigationController.init(rootViewController: favVC)
        
        self.viewControllers = [secondTabNavController, thirdTabNavController]
        
//        let item1 = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0)
        let item2 = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        let item3 = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.circle"), tag: 1)
        
//        firstTabNavController.tabBarItem = item1
        secondTabNavController.tabBarItem = item2
        thirdTabNavController.tabBarItem = item3
        
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().backgroundColor = .white
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}
