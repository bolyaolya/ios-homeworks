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
    
    var favPosts : [Favorite] = []
    
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
    
    func getPosts() -> [Favorite] {
        let answer = Favorite.fetchRequest()
        do {
            let posts = try persistentContainer.viewContext.fetch(answer)
            favPosts = posts
            return favPosts
        } catch {
            print(error)
        }
        return []
    }
    
    func reloadPosts() {
        let request = Favorite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        do {
            let fetchedPost = try persistentContainer.viewContext.fetch(request)
            favPosts = fetchedPost
        } catch let error {
            print("Ошибка \(error.localizedDescription)")
            favPosts = []
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
    
    func addPostToFav(author: String, descriptionText : String, image : String, likes : Int, views : Int, id : Int) {
        backgroundContext.perform {
            let newFavPost = Favorite(context: self.backgroundContext)
            newFavPost.author = author
            newFavPost.descriptionText = descriptionText
            newFavPost.image = image
            newFavPost.likes = Int64(likes)
            newFavPost.views = Int64(views)
            
            self.saveBackgroundContext()
            self.reloadPosts()
        }
    }
    
    func deletePostFromFav(post : Favorite) {
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadPosts()
        favPosts.removeAll { $0 == post }
    }
    
    func getSearchResult(by: String) {
        let answer = Favorite.fetchRequest()
        answer.predicate = NSPredicate(format: "author CONTAINS[c] %@", by)
        answer.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        
        do {
            let sortedPosts = try persistentContainer.viewContext.fetch(answer)
            favPosts = sortedPosts
        } catch let error {
            print("Ошибка \(error.localizedDescription)")
        }
    }
}















