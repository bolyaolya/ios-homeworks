//
//  TabBarController.swift
//  Navigation
//
//  Created by Ольга Бойко on 15.08.2022.
//

import UIKit

class TabBarController: UITabBarController {

    //Создаем 2 навигационных контроллера
    var firstTabNavigationController : UINavigationController!
    var secondTabNavigationController : UINavigationController!
    var thirdTabNavigationController : UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        //Объявляем стартовый экран и создаем навигационные контроллеры
        firstTabNavigationController = UINavigationController.init(rootViewController: FeedViewController())
        secondTabNavigationController = UINavigationController.init(rootViewController: LogInViewController())
        thirdTabNavigationController = UINavigationController.init(rootViewController: ProfileViewController())
        secondTabNavigationController.navigationBar.isHidden = false
        
        //Добавляем навигационные контроллеры в контейнер таббара
        self.viewControllers = [firstTabNavigationController, secondTabNavigationController]
        
        //Создаем кнопки и привязываем к ним контроллеры
        let item1 = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0)
        let item2 = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        //Закрепляем за каждым контроллером таббар иконку
        firstTabNavigationController.tabBarItem = item1
        secondTabNavigationController.tabBarItem = item2
        
        //Кастомизируем таббар
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().backgroundColor = .white
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}
