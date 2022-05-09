//
//  NewsUser+CoreDataProperties.swift
//  
//
//  Created by Sinda Arous on 4/5/2022.
//
//

import Foundation
import CoreData


extension NewsUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsUser> {
        return NSFetchRequest<NewsUser>(entityName: "NewsUser")
    }

    @NSManaged public var dateNews: String?
    @NSManaged public var descriptionNews: String?
    @NSManaged public var idNews: String?
    @NSManaged public var idUser: String?
    @NSManaged public var imageNews: String?
    @NSManaged public var title: String?

}
