//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Ольга Бойко on 10.05.2023.
//

import UIKit

protocol AppCoordinatorProtocol : Coordinator {
    func showLogin()
    func showTabBar()
}

class AppCoordinator : AppCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .app }
    
    func start() {
        showLogin()
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showLogin() {
        let loginCoordinator = loginCoordinator.init(navigationController)
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
    func showTabBar() {
        let tabBarCoordinator = TabBarCoordinator.init(navigationController)
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
    
}
