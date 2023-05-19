//
//  FeedModel.swift
//  Navigation
//
//  Created by Ольга Бойко on 05.05.2023.
//

import UIKit

struct FeedModel {
    
    var password = "secretWord"
    
    func check(yourWord : String) -> Bool {
        password == yourWord ? true : false
    }
}
