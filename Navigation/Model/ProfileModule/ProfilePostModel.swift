//
//  PostModel.swift
//  Navigation
//
//  Created by Ольга Бойко on 05.01.2023.
//

import UIKit

    //MARK: - Properties

    public struct Post {
        var author : String
        var description: String
        var image: UIImage?
        var likes: Int
        var views: Int
        var id : Int?
    }
    

    public var post : [Post] = [
        Post(author: "Стивен Кинг", description: "11/22/63", image: UIImage(named: "112263"), likes: 3048, views: 5093, id: 0),
        Post(author: "Михаил Булгаков", description: "Мастер и Маргарита", image: UIImage(named: "master"), likes: 2048, views: 4809, id: 1),
        Post(author: "Фредерик Бакман", description: "Тревожные люди", image: UIImage(named: "trevozhnye"), likes: 1033, views: 2048, id: 2),
        Post(author: "Дэн Браун", description: "Код да Винчи", image: UIImage(named: "daVinci"), likes: 2567, views: 3493, id: 3)
    ]

    public var newPost = Post(author: "Drag&Drop", description: "", image: UIImage(), likes: 0, views: 0)
