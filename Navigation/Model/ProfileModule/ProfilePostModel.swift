//
//  PostModel.swift
//  Navigation
//
//  Created by Ольга Бойко on 05.01.2023.
//

import UIKit

    //MARK: - Properties

    public struct Post {
        let author : String
        let description: String
        let image: String
        var likes: Int
        var views: Int
        var id : Int
    }

    public var post : [Post] = [
        Post(author: String(localized: "stevenK"), description: "11/22/63", image: "112263", likes: 3048, views: 4044, id: 0),
        Post(author: String(localized: "bulgakov"), description: String(localized: "bulgakovMaster"), image: "master", likes: 2048, views: 144, id: 1),
        Post(author: String(localized: "bakman"), description: String(localized: "nervousBakman"), image: "trevozhnye", likes: 1033, views: 2048, id: 2),
        Post(author: String(localized: "brawn"), description: String(localized: "infBrawn"), image: "daVinci", likes: 2567, views: 5999, id: 3)
    ]
