//
//  CoreDataManager.swift
//  CoreDataNumberFacts
//
//  Created by Howard Chang on 4/9/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    private var users = [User]()
    private var posts = [Post]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func createUser(name:String, dob: Date) -> User {
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        do {
            try context.save()
        } catch {
            print("error saving \(error)")
        }
        return user
    }
    
    public func fetchUsers() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest())
        } catch {
            print("fetch user error \(error)")
        }
        return users
    }
    
    public func createPost(user: User, numberFact: Double, title: String) -> Post {
           let post = Post(entity: Post.entity(), insertInto: context)
           post.number = numberFact
           post.title = title
           post.user = user
        do {
            try context.save()
        } catch {
            print("error creating post \(error)")
        }
        return post
       }
    
    public func fetchPosts() -> [Post] {
        do {
            posts = try context.fetch(Post.fetchRequest())
        } catch {
            print("failed to fetch posts \(error)")
        }
        return posts
    }
    
    @discardableResult
    public func deletePost(post: Post) -> Bool {
        var deleted = false
        context.delete(post)
        do {
            try context.save()
            deleted = true
        } catch {
            print("error saving after deleteing \(error)")
        }
        return deleted
    }
    
}
