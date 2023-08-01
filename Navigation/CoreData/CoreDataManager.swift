//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Ольга Бойко on 27.07.2023.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    
    static let defaultManager = CoreDataManager()
    
    var posts : [Favorite] = []
    
    lazy var persistentContainer : NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var backgroundContext : NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    init() {
        reloadPosts()
    }
    
    func reloadPosts() {
        let request = Favorite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        do {
            let fetchedPost = try persistentContainer.viewContext.fetch(request)
            posts = fetchedPost
        } catch let error {
            print("Ошибка \(error.localizedDescription)")
            posts = []
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveBackgroundContext() {
        let context = backgroundContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func addPostToFav(author: String, descriptionText : String, image : String, likes : Int64, views : Int64, id : Int64) {
        backgroundContext.perform { [self] in
            let newFavPost = Favorite(context: backgroundContext)
            newFavPost.author = author
            newFavPost.descriptionText = descriptionText
            newFavPost.image = image
            newFavPost.likes = likes
            newFavPost.views = views
            
            saveBackgroundContext()
            reloadPosts()
        }
    }
    
    func deletePostFromFav(post : Favorite) {
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadPosts()
        posts.removeAll { $0 == post }
    }
}















