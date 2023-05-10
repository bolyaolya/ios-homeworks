//
//  Coordinator.swift
//  Navigation
//
//  Created by Ольга Бойко on 10.05.2023.
//

import UIKit

protocol Coordinator : AnyObject {
    
    var navigationController : UINavigationController { get set }
    
    var childCoordinators: [Coordinator] { get set }
    
    var type : CoordinatorType { get }
    
    func start()
    
    init(_ navigationController : UINavigationController)
}

enum CoordinatorType {
    case app, login, tab
}
