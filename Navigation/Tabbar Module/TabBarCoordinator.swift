//
//  TabBarCoordinator.swift
//  Navigation
//
//  Created by Ольга Бойко on 10.05.2023.
//

import UIKit

protocol TabBarCoordinatorProtocol : Coordinator {
    var tabBarController : UITabBarController { get set }
}

class TabBarCoordinator : Coordinator {
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    

    var type: CoordinatorType { .tab }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showTabBar()
    }
    
    func showTabBar() {
        let tabBar = TabBarController()
        navigationController.pushViewController(tabBar, animated: true)
    }
    
    
}
