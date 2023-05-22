//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Ольга Бойко on 10.05.2023.
//

import Foundation

final class FeedViewModel {
    
    let password = FeedModel().password
    
    func check(yourWord : String) -> Bool {
        password == yourWord ? true : false
    } 
}
