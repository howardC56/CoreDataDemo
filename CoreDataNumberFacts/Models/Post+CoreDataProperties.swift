//
//  Post+CoreDataProperties.swift
//  CoreDataNumberFacts
//
//  Created by Howard Chang on 4/9/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var number: Double
    @NSManaged public var title: String?
    @NSManaged public var user: User?

}
