//
//  loginCoordinator.swift
//  Navigation
//
//  Created by Ольга Бойко on 10.05.2023.
//

import UIKit

protocol LoginCoordinatorProtocol : Coordinator {
    func showLoginVC()
}

class loginCoordinator : LoginCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .login }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginVC()
    }
    
    func showLoginVC() {
        let loginVC = LogInViewController()
        navigationController.pushViewController(loginVC, animated: true)
    }
}
