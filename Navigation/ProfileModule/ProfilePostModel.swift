//
//  PostModel.swift
//  Navigation
//
//  Created by Ольга Бойко on 05.01.2023.
//

import UIKit

    //свойства

    public struct Post {
        let author : String
        let description: String
        let image: String
        var likes: Int
        var views: Int
    }


    public var post : [Post] = [
        Post(author: "Стивен Кинг", description: "11/22/63", image: "112263", likes: 3048, views: 5093),
        Post(author: "Михаил Булгаков", description: "Мастер и Маргарита", image: "master", likes: 2048, views: 4809),
        Post(author: "Фредерик Бакман", description: "Тревожные люди", image: "trevozhnye", likes: 1033, views: 2048),
        Post(author: "Дэн Браун", description: "Код да Винчи", image: "daVinci", likes: 2567, views: 3493)
    ]
