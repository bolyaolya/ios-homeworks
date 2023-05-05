//
//  FeedModel.swift
//  Navigation
//
//  Created by Ольга Бойко on 05.05.2023.
//

import UIKit

class FeedModel {
    
    private let password : String = "secretWord"
    
    func check(word: String) -> Bool {
        password == word ? true : false 
    }
}
