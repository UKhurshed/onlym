//
//  Article+CoreDataProperties.swift
//  test_problem_onlym
//
//  Created by Khurshed Umarov on 18.10.2021.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var text: String?

}

extension Article : Identifiable {

}
