//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Ольга Бойко on 10.05.2023.
//

import Foundation

final class FeedViewModel {
    
    //добавляем действие по тапу - проверка кодового слова
    func checkingPassword() {
        
        let input = FeedViewController().textField.text ?? ""
        let result : Bool = FeedModel().check(yourWord: input)
        if result == true {
            FeedViewController().answerText.text = "You are right!"
            FeedViewController().answerText.textColor = .green
        } else {
            FeedViewController().answerText.text = "You are wrong :("
            FeedViewController().answerText.textColor = .red
        }
    }
}
