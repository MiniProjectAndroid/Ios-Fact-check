//
//  Book.swift
//  FactCheck
//
//  Created by Med Aziz on 21/4/2022.
//

import Foundation
import CoreData

@objc(Book)
class Book: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var date: String!
    @NSManaged var image: String!
    @NSManaged var comment: String!
    @NSManaged var like: String!
    @NSManaged var deletedDate: Date?
    @NSManaged var title: String!
    @NSManaged var name: String!
}
