//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Ольга Бойко on 10.05.2023.
//

import Foundation

final class FeedViewModel {
    
    let feedModel = FeedModel()
    
    var answerText = Dynamic("")
    
    func checkPassword(password : String) -> Bool {
        
        if password == feedModel.password {
            answerText.value = "You are right!"
            return true
        } else {
            answerText.value = "You are wrong :("
            return false
        }
    }
}
